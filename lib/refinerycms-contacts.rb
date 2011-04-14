require 'refinery'

module Refinery
  module Contacts
    class Engine < Rails::Engine
      initializer "static assets" do |app|
        app.middleware.insert_after ::ActionDispatch::Static, ::ActionDispatch::Static, "#{root}/public"
      end

      config.after_initialize do
        Refinery::Plugin.register do |plugin|
          plugin.name = "contacts"
          plugin.menu_match = /^\/?(admin|refinery)\/(contacts|notes)/
          plugin.activity = {
            :class => Contact,
            :title => 'name'
          }
        end
      end
    end
  end
end
