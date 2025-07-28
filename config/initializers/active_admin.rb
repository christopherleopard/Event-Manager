ActiveAdmin.setup do |config|
  config.site_title = "Admin Dashboard"

  config.use_webpacker = false

  config.clear_stylesheets!
  config.register_stylesheet "active_admin.css"
  config.register_stylesheet "global.css"

  config.register_javascript "https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"
  config.register_javascript "https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"

  config.authentication_method = :authenticate_admin_user!
  config.comments = false

  config.current_user_method = :current_admin_user

  config.logout_link_path = :destroy_admin_user_session_path

  config.batch_actions = false

  config.filter_attributes = [ :encrypted_password, :password, :password_confirmation ]

  config.localize_format = :long
end
