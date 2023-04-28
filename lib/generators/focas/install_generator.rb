# frozen_string_literal: true

require 'generators/focas/helpers'
require 'rails/generators/base'

module Focas
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Focas::Generators::Helpers

      source_root File.expand_path('templates', __dir__)

      def copy_initializer_file
        template 'initializer.rb', focas_config_path
      end
    end
  end
end
