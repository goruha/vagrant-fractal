module VagrantPlugins
  module Fractal
    class Plugin < Vagrant.plugin(2)
      ENVIRONMENT_VARIABLE = 'VAGRANT_DOCKER_BOXES'

      name 'vagrant-fractal'
      description 'Vagrant plugin to config multiple docker boxes'

      config :fractal do
        require_relative 'config'
        Config
      end
    end # Plugin
  end # Fractal
end # VagrantPlugins
