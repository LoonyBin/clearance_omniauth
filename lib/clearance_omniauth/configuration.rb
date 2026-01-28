module ClearanceOmniauth
  # Configuration is available in your Rails' application.rb as
  # config.clearance_omniauth. See README for example.
  #
  class Configuration
    class << self
      # URL to redirect to after successful login
      def after_login_url
        @after_login_url ||= "/"
      end

      def after_login_url=(value)
        @after_login_url = value
      end

      # URL to redirect to if login fails
      def login_failure_url
        @login_failure_url ||= "/"
      end

      def login_failure_url=(value)
        @login_failure_url = value
      end

      # Reset configuration to defaults (useful for testing)
      def reset!
        @after_login_url = nil
        @login_failure_url = nil
      end
    end
  end
end
