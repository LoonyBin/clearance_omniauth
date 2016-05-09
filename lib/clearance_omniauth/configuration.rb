module ClearanceOmniauth

  # Configuration is available in your Rails' <tt>application.rb</tt> as
  # <tt>config.clearance_omniauth</tt>. See README for example.
  #
  class Configuration

    # Returns formats for which the Middleware is enabled
    #
    # def self.api_formats
    #   @api_formats ||= %w[  json xml  ]
    # end

    # Set the url to go to if after logging in
    def self.after_login_url
      @after_login_url ||= '/'
    end
    def self.after_login_url=(value)
      @after_login_url = value
    end

    # Set the url to go to if login fails
    def self.login_failure_url
      @login_failure_url ||= '/'
    end
    def self.login_failure_url=(value)
      @login_failure_url = value
    end

  end

end
