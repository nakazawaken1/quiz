Rails.application.config.generators do |g|
    g.javascripts true
    g.stylesheets true
    g.helper false
    g.jbuilder false
    g.test_framework :rspec,
      fixture: true,
      view_specs: false,
      helper_specs: false,
      routing_specs: false,
      controller_specs: false,
      request_specs: true
  end