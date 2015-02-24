require 'yaml'

module VagrantPlugins
  module Environments
    class Fractal < Vagrant.plugin(2, :config)
      attr_accessor :file, :active, :default_environment
      attr_reader :data

      DEFAULT_SETTINGS = {
        file: 'fractal.yaml'
      }.freeze

      def initialize
        @file = UNSET_VALUE
        @active = UNSET_VALUE
        @default_environment = UNSET_VALUE
      end

      def file=(path)
        @file = path unless path.empty?
      end

      def active

        if @active == UNSET_VALUE
          @active = ENV['VAGRANT_ENVIRONMENT'].nil? ? @default_environment : ENV['VAGRANT_ENVIRONMENT']
        end

        @active

      end

      def data
        validate(nil)
        YAML.load_file(@file)
      end

      def validate(_)
        finalize!
        errors = _detected_errors

        if File.file?(@file)
          begin
            environments = YAML.load_file(@file)
            p environments.inspect
            errors.push("There is no #{@active} environment in #{@file}") unless environments.has_key?(@active)
          rescue Exception
            errors.push("file #{@file} have wrong format")
          end
        else
          errors.push("file #{@file} does not exists") 
        end

        { 'environments' => errors }
      end

      def finalize! 
        @file = DEFAULT_SETTINGS[:file] if @file == UNSET_VALUE
        active
      end

    end #Config
  end #Envrionments
end # VagrantPlugins
