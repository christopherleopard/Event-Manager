# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "custom-message" do
      h2 "WLPS Admin Tools", class: "text-center"
      para "Use buttons below to navigate to the different Admin tools to manage content on the website.", class: "text-center"
    end

    div class: "admin_tools_wrapper" do
      button class: "primary-btn" do
        link_to "Drills Management", admin_drills_path, class: "text-white"
      end
    end
  end
end
