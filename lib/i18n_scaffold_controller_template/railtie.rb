require 'rails/railtie'

class I18nScaffoldControllerTemplate
  class Railtie < ::Rails::Railtie
    if Rails::VERSION::MAJOR >= 4
      generators do |app|
        Rails::Generators.configure! app.config.generators
        Rails::Generators.hidden_namespaces.uniq!
        require 'i18n_scaffold_controller_template/generators/rails/scaffold_controller_generator'
      end
    end
  end
end
