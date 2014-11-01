module Convoy
    class App
        #TODO ensure that every command must have an action
        class << self
            def create(option_string = '', &block)
                self.new(option_string, &block).setup_application.execute
                exit(0)
            end
        end

        attr_reader :setup, :option_string

        def initialize(option_string, &block)
            @option_string = option_string
            @setup = nil
            @block = block
        end

        def setup_application
            old_error_sev_threshold = error_logger.sev_threshold
            begin
                error_logger.sev_threshold = ::Logger::DEBUG
                cli_app_configuration = Convoy::Setup::Dsl::Global.new(&@block)
                @setup = Convoy::SetupAccessor.new(cli_app_configuration)
                self
            rescue => e
                handle_convoy_error(e)
            ensure
                error_logger.sev_threshold = old_error_sev_threshold
            end
        end

        def execute
            begin
                AutoOptions.augment(setup)

                cli_options = current_cli_options(option_string)

                auto_options = Convoy::GlobalPreParser.new(setup).parse(cli_options.dup)
                Convoy::Logger.setup_error_logger(auto_options)

                #now we can start doing error logging everything above here has to be rock solid

                configuration = Convoy::Setup::Configuration::Loader.new(setup, auto_options).configuration

                invoked_options, arguments = Convoy::OptionParser.new(configuration, setup).parse(cli_options)
                context = context_from_options(invoked_options[:global])
                action = setup.action_for(context)
                current_command = context.empty? ? :global : context.last
                raise Convoy::ClientError.new("No action defined for command '#{current_command}'") unless action
                actual_arguments = Convoy::Arguments.read(arguments, setup.arguments_required_for(context))
            rescue => e
                handle_convoy_error(e)
            end
            execute_action(action, invoked_options, actual_arguments, configuration.user)
        end

        private

        def current_cli_options(option_string)
            passed_in_options = Convoy::Utils.tokenize_option_string(option_string)
            passed_in_options.empty? ? ARGV.dup : passed_in_options
        end

        def execute_action(action, options, arguments, user_config)
            begin
                #execute before servants here
                action.call(options, arguments, user_config)
                    #execute after servants here
            rescue => e
                handle_action_error(e)
            end
        end

        def context_from_options(options)
            commands_in_order(options)
        end

        def commands_in_order(options, commands = [])
            if options[:commands].keys.empty?
                commands
            else
                command = options[:commands].keys.first
                commands << command
                commands_in_order(options[:commands][command], commands)
            end
        end

        def handle_convoy_error(e)
            if e.kind_of?(Convoy::UserError)
                print_stacktrace(e)
                error_logger.debug { "Convoy app failed to execute successfully, due to user error" }
                exit(Convoy::USER_ERROR_EXIT_CODE)
            elsif e.kind_of?(Convoy::ClientError)
                print_stacktrace(e)
                error_logger.debug { "Convoy app failed to execute successfully, due to client setup error" }
                exit(Convoy::CLIENT_ERROR_EXIT_CODE)
            else
                print_convoy_error_message(e)
                error_logger.debug { "Convoy app failed to execute successfully, due to internal error" }
                exit(Convoy::INTERNAL_ERROR_EXIT_CODE)
            end
        end

        def handle_action_error(e)
            if e.kind_of?(Convoy::Error)
                print_convoy_error_message(e)
                error_logger.debug { "Convoy app failed to execute successfully, due to internal error" }
                exit(Convoy::INTERNAL_ERROR_EXIT_CODE)
            else
                print_stacktrace(e)
                error_logger.debug { "Convoy app failed to execute successfully, due to unknown error" }
                exit(Convoy::EXTERNAL_ERROR_EXIT_CODE)
            end
        end

        def print_stacktrace(e)
            error_logger.error { e.message }
            error_logger.debug { e }
        end

        def print_convoy_error_message(e)
            print_stacktrace(e)
            error_logger.warn { "An internal Convoy error has occurred, you should probably report it by creating an issue on github! To get a stacktrace, up the verbosity level to DEBUG and execute your command again. Use --help for details." }
        end
    end
end
