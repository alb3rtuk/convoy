module Convoy
    module Formatter
        class DefaultHelpFormatter
            attr_reader :setup, :context

            def initialize(setup, context)
                @setup   = setup
                @context = context
            end

            def print(parser)
                options         = Options.new(parser, setup, context)
                commands        = Commands.new(setup, context)
                current_command = Commands.command_for(setup, context)
                # Uncomment the following line if you want the screen
                # to be cleared before the --help messages show.
                #
                # system('clear')
                puts
                StreamOutputFormatter.new($stdout, :max_output_width => Terminal.width) do |f|
                    if setup.summary_for != '' && !setup.summary_for.nil?
                        f.puts setup.summary_for, :newlines => 2
                    end
                    # if (setup.description_for != '' && !setup.description_for.nil?) && current_command.summary == setup.summary_for
                    #     f.indent(4) do |f_inner|
                    #         f_inner.puts setup.description_for, :newlines => 2
                    #     end
                    # end
                    name_help(current_command, f)
                    version_help(current_command, f)
                    usage_help(current_command, f)
                    commands_help(commands, f)
                    options_help(options, f)
                end
            end

            private

            def name_help(current_command, f)
                if setup.description_for(context) != ''
                    f.indent(4) do |f|
                        f.puts("\x1B[38;5;250m#{setup.description_for(context)}\x1B[0m", :newlines => 2)
                    end
                end
            end

            def version_help(current_command, f)
                if setup.version
                    f.indent(4) do |f|
                        f.puts "\x1B[38;5;250mVersion: \x1B[38;5;46m#{setup.version}\x1B[0m", :newlines => 1
                    end
                end
            end

            def usage_help(current_command, f)
                f.indent(4) do |f|
                    f.puts "\x1B[38;5;250m  Usage: \x1B[38;5;46m#{current_command.usage}\x1B[0m", :newlines => 2
                end
            end

            def options_help(options, f)
                if options.count > 0
                    f.puts "  \x1B[38;5;255mFLAGS\x1B[0m"
                    f.indent(4) do |f|
                        f.grid(:columns => 3) do |t|
                            options.each do |option|
                                unless option.usage == '--verbosity, <s>' || option.usage == '--error-output-format, <s>' || option.usage == '-v, --version'
                                    t.row option.usage.ljust(10, ' '), " \xe2\x86\x92 ", option.description
                                    option_conflicts_help(option, t)
                                    option_dependencies_help(option, t)
                                    option_validations_help(option, t)
                                end
                            end
                        end
                        f.newline
                    end
                end
            end

            def option_conflicts_help(option, t)
                if option.has_conflicts?
                    t.row '', '', "- #{option.conflicts}"
                end
            end

            def option_dependencies_help(option, t)
                if option.has_dependencies?
                    t.row '', '', "- #{option.dependencies}"
                end
            end

            def option_validations_help(option, t)
                if option.has_validations?
                    option.validations.each do |validation|
                        t.row '', '', "- #{validation}"
                    end
                end
            end

            def commands_help(commands, f)
                if commands.count > 0
                    f.puts "  \x1B[38;5;255mCOMMANDS\x1B[0m"
                    f.indent(4) do |f|
                        f.grid(:columns => 3) do |t|
                            commands.each do |command|
                                t.row command.name_with_aliases.ljust(10, ' '), " \xe2\x86\x92 ", command.outline
                            end
                        end
                        f.newline
                    end
                end
            end
        end
    end
end
