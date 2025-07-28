if Rails.env.production?
  Rails.application.config.after_initialize do
    require Rails.root.join("lib/active_admin/views/header.rb").to_s
  end
else
  Rails.application.config.to_prepare do
    load Rails.root.join("app/overrides/active_admin/custom_header.rb")
  end
end
