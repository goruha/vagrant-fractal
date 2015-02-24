module VagrantPlugins
  module Fractal
    ENVIRONMENT_VARIABLE = 'VAGRANT_DOCKER_BOXES'
    class Plugin < Vagrant.plugin(2)

      name 'vagrant-fractal'
      description 'Vagrant plugin to config multiple docker boxes'

      RbConfig :fractal do
        require_relative 'config'
        Config
      end
    end # Plugin
  end # Fractal
end # VagrantPlugins
