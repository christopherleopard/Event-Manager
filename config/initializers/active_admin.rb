ActiveAdmin.setup do |config|
  config.site_title = "Event Manager Admin"

  config.use_webpacker = false

  config.clear_stylesheets!
  config.register_stylesheet "active_admin.css"
  config.register_stylesheet "global.css"

  config.authentication_method = :authenticate_admin_user!

  config.current_user_method = :current_admin_user

  config.logout_link_path = :destroy_admin_user_session_path

  config.batch_actions = false

  config.filter_attributes = [ :encrypted_password, :password, :password_confirmation ]

  config.localize_format = :long
end
