module Vagrant
  module Plugin
    module V2
      # This is the base class for a CLI command.
      class Command
        protected
        # Parses the options given an OptionParser instance.
        #
        # This is a convenience method that properly handles duping the
        # originally argv array so that it is not destroyed.
        #
        # This method will also automatically detect "-h" and "--help"
        # and print help. And if any invalid options are detected, the help
        # will be printed, as well.
        #
        # If this method returns `nil`, then you should assume that help
        # was printed and parsing failed.
        def parse_options(opts=nil)
          p "dasdas"
          # Creating a shallow copy of the arguments so the OptionParser
          # doesn't destroy the originals.
          argv = @argv
          # Default opts to a blank optionparser if none is given
          opts ||= OptionParser.new
          # Add the help option, which must be on every command.
          opts.on_tail("-h", "--help", "Print this help") do
            safe_puts(opts.help)
            return nil
          end

          opts.on("-d DOCKER_BOXES", "--docker DOCKER_BOXES", "Allow only provided docker boxes") do |fractal_boxes|
            ENV[VagrantPlugins::Fractal::ENVIRONMENT_VARIABLE] = fractal_boxes if !ENV.has_key?(VagrantPlugins::Fractal::ENVIRONMENT_VARIABLE) ||  ENV[VagrantPlugins::Fractal::ENVIRONMENT_VARIABLE].nil?
          end

          opts.parse!(argv)
          return argv
        rescue OptionParser::InvalidOption
          raise Errors::CLIInvalidOptions, help: opts.help.chomp
        end
      end
    end
  end
end
