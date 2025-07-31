# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "dashboard" do
      div class: "custom-message" do
        h2 "WLPS Admin Tools", class: "text-center"
        para "Use buttons below to navigate to the different Admin tools to manage content on the website.", class: "text-center"
      end

      div class: "admin_tools_wrapper" do
        button class: "tool-btn" do
          link_to "Emergency Alerts Management", admin_emergency_alerts_path, class: "text-white"
        end

        button class: "tool-btn" do
          link_to "Events Management", admin_events_path, class: "text-white"
        end

        button class: "tool-btn" do
          link_to "Staff Management", admin_staffs_path, class: "text-white"
        end

        button class: "tool-btn" do
          link_to "Food Service Management", admin_food_services_path, class: "text-white"
        end

        button class: "tool-btn" do
          link_to "Board Book Management", admin_board_books_path, class: "text-white"
        end

        button class: "tool-btn" do
          link_to "Board Minutes Management", admin_board_minutes_path, class: "text-white"
        end

        button class: "tool-btn" do
          link_to "Newsletter Management", admin_newsletters_path, class: "text-white"
        end

        button class: "tool-btn" do
          link_to "Drills Management", admin_drills_path, class: "text-white"
        end
      end
    end
  end
end
