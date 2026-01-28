require "rails/generators/base"

module ClearanceOmniauth
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      desc "Installs ClearanceOmniauth: copies migrations and creates initializer"

      def copy_migrations
        rake "clearance_omniauth:install:migrations"
      end

      def create_omniauth_initializer
        copy_file "config/initializers/omniauth.rb", "config/initializers/omniauth.rb"
      end

      def add_authentications_to_user
        inject_into_class "app/models/user.rb", "User" do
          <<-RUBY
  has_many :authentications, class_name: "ClearanceOmniauth::Authentication", dependent: :destroy

  def apply_omniauth(omniauth)
    if email.blank? && omniauth["info"].present?
      self.email = omniauth["info"]["email"]
    end
    authentications.build(provider: omniauth["provider"], uid: omniauth["uid"])
  end

  def password_required?
    return false if authentications.any? && password.blank?
    super
  end

          RUBY
        end
      end

      def mount_engine
        route 'mount ClearanceOmniauth::Engine => "/auth"'
      end

      def display_readme
        readme "README" if File.exist?(File.join(self.class.source_root, "README"))
      end
    end
  end
end
