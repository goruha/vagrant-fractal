module VagrantPlugins
  module Fractal
    class Environment < Vagrant.plugin(2, :config)

      def define(config, &block)
        settings = config.environments.data
        settings["machines"].each do |name, options|
          next if options.has_key?('external') && options['external']
          machine_name = [config.environments.active, name].join('__')
          config.vm.define machine_name do |machine|
            block.call(machine, name, options, settings["configs"])
          end
        end
      end

      def validate(_)
        errors = _detected_errors
        { 'environment' => errors }
      end

    end #Environment
  end #Envrionments
end # VagrantPlugins
