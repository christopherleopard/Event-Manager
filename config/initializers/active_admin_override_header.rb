Rails.application.config.to_prepare do
  load Rails.root.join("app/overrides/active_admin/custom_header.rb")
end
