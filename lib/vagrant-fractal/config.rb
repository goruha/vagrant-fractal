require 'yaml'

module VagrantPlugins
  module Fractal
    class Config < Vagrant.plugin(2, :config)
      attr_accessor :file
      attr_reader :active

      DEFAULT_SETTINGS = {
        file: 'fractal.yaml'
      }.freeze

      def initialize
        @file = UNSET_VALUE
        @filter = UNSET_VALUE
        @raw = nil
      end

      def file=(path)
        @file = path unless path.empty?
      end

      def active
        validate(nil)
        @filter == UNSET_VALUE ? raw.keys : @filter
      end

      def data
        validate(nil)
        raw.select { |key,_| active.include? key }
      end

      def validate(_)
        finalize!
        errors = _detected_errors

        if File.file?(@file)
          begin
            unless @filter == UNSET_VALUE
              @filter.each do |box|
                errors.push("There is no #{box} box in #{@file}") unless raw.has_key?(box)
              end
            end
          rescue Exception
            errors.push("file #{@file} have wrong format")
          end
        else
          errors.push("file #{@file} does not exists") 
        end

        { 'fractal' => errors }
      end

      def finalize! 
        @file = DEFAULT_SETTINGS[:file] if @file == UNSET_VALUE
        @filter = docker_boxes.split(',').map{|box| box.strip } unless docker_boxes == UNSET_VALUE
      end

      private

      def raw
        @raw ||= YAML.load_file(@file)
      end

      def docker_boxes
        ENV[VagrantPlugins::Fractal::ENVIRONMENT_VARIABLE].nil? ? UNSET_VALUE : ENV[VagrantPlugins::Fractal::ENVIRONMENT_VARIABLE];
      end

    end #Config
  end #Envrionments
end # VagrantPlugins
