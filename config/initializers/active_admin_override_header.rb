if Rails.env.production?
  require Rails.root.join("lib/active_admin/header_override.rb").to_s
else
  Rails.application.config.to_prepare do
    load Rails.root.join("app/overrides/active_admin/custom_header.rb")
  end
end
