require 'rails/generators'
require 'rails/generators/rails/scaffold_controller/scaffold_controller_generator'

module Rails
  module Generators
    class ScaffoldControllerGenerator < NamedBase
      class_option :with_api, type: :boolean,
                         desc: "Generates also API controller in 'app/contorllers/api'"
      class_option :api_version, type: :string,
                         desc: "Adds specified path as version to 'app/contorllers/api'"

      source_paths.unshift File.expand_path('../templates', __FILE__)

      def create_api_controller_with_namespace
        return unless options.with_api?
        path = ['app/controllers/api']
        path << options[:api_version].underscore if options[:api_version].present?
        path << controller_class_path << "#{controller_file_name}_controller.rb"
        template 'api_controller.rb', File.join(*path)
      end

    end
  end
end
