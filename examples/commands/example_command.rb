module Convoy
    class ExampleCommand < ::Convoy::ActionCommand::Base
        def execute
            Convoy::Logger.output.puts "Command: #{command_name}"
            Convoy::Logger.output.puts "Options: #{options}"
            Convoy::Logger.output.puts "Command options: #{command_options}"
            Convoy::Logger.output.puts "Arguments: #{arguments}"
            if config
                Convoy::Logger.output.puts "User config: #{config}"
            end
        end
    end
end
