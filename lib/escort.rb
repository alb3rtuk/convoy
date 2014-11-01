autoload :Nesty,                            "nesty"

module Convoy
  autoload :VERSION,                        "convoy/version"
  autoload :Trollop,                        "convoy/trollop"
  autoload :Utils,                          "convoy/utils"
  autoload :Arguments,                      "convoy/arguments"
  autoload :Logger,                         "convoy/logger"
  autoload :SetupAccessor,                  "convoy/setup_accessor"
  autoload :OptionDependencyValidator,      "convoy/option_dependency_validator"
  autoload :Validator,                      "convoy/validator"
  autoload :AutoOptions,                    "convoy/auto_options"
  autoload :GlobalPreParser,                "convoy/global_pre_parser"
  autoload :OptionParser,                   "convoy/option_parser"
  autoload :App,                            "convoy/app"

  autoload :Error,                          "convoy/error/error"
  autoload :BaseError,                      "convoy/error/error"
  autoload :UserError,                      "convoy/error/error"
  autoload :InternalError,                  "convoy/error/error"
  autoload :ClientError,                    "convoy/error/error"
  autoload :TransientError,                 "convoy/error/error"

  module Formatter
    autoload :Option,                       "convoy/formatter/option"
    autoload :Options,                      "convoy/formatter/options"
    autoload :Command,                      "convoy/formatter/command"
    autoload :Commands,                     "convoy/formatter/commands"
    autoload :GlobalCommand,                "convoy/formatter/global_command"
    autoload :ShellCommandExecutor,         "convoy/formatter/shell_command_executor"
    autoload :Terminal,                     "convoy/formatter/terminal"
    autoload :StringSplitter,               "convoy/formatter/string_splitter"
    autoload :CursorPosition,               "convoy/formatter/cursor_position"
    autoload :StreamOutputFormatter,        "convoy/formatter/stream_output_formatter"
    autoload :StringGrid,                   "convoy/formatter/string_grid"
    autoload :DefaultHelpFormatter,         "convoy/formatter/default_help_formatter"
  end

  module Setup
    module Dsl
      autoload :Options,                    "convoy/setup/dsl/options"
      autoload :Action,                     "convoy/setup/dsl/action"
      autoload :Command,                    "convoy/setup/dsl/command"
      autoload :ConfigFile,                 "convoy/setup/dsl/config_file"
      autoload :Global,                     "convoy/setup/dsl/global"
    end

    module Configuration
      module Locator
        autoload :Base,                     "convoy/setup/configuration/locator/base"
        autoload :DescendingToHome,         "convoy/setup/configuration/locator/descending_to_home"
        autoload :ExecutingScriptDirectory, "convoy/setup/configuration/locator/executing_script_directory"
        autoload :SpecifiedDirectory,       "convoy/setup/configuration/locator/specified_directory"
        autoload :Chaining,                 "convoy/setup/configuration/locator/chaining"
      end

      autoload :MergeTool,                  "convoy/setup/configuration/merge_tool"
      autoload :Instance,                   "convoy/setup/configuration/instance"
      autoload :Reader,                     "convoy/setup/configuration/reader"
      autoload :Writer,                     "convoy/setup/configuration/writer"
      autoload :Generator,                  "convoy/setup/configuration/generator"
      autoload :Loader,                     "convoy/setup/configuration/loader"
    end
  end

  module ActionCommand
    autoload :Base,                         "convoy/action_command/base"
    autoload :ConvoyUtilityCommand,         "convoy/action_command/convoy_utility_command"
  end
end

at_exit do
  Convoy::Logger.close
end

def error_logger
  Convoy::Logger.error
end

def output_logger
  Convoy::Logger.output
end


