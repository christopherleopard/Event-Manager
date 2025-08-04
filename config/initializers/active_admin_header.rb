module ActiveAdmin
  module Views
    class Header < Component
      def build(namespace, menu)
        super(id: "main-header", class: "main-header")

        div class: "top_header py-0" do
          div class: "container d-flex justify-content-between py-2" do
            div class: "d-flex" do
              span { link_to image_tag("fb.png", alt: "Facebook"), "#", class: "text-blue-600" }
              span { link_to image_tag("x.png", alt: "X"), "#", class: "text-blue-600" }
            end
            div class: "contact_info" do
              span { link_to "(739) 449-4464", "tel:7394494464", class: "text-red"}
            end
          end
          div class: "custom-select-wrapper text-center p-20" do
            current_path = request.fullpath
            select_tag "page_redirect",
              options_for_select([
                ['Emergency Alerts Management', '/admin/emergency_alerts'],
                ['Events Management', '/admin/events'],
                ['Staff Management', '/admin/staff'],
                ['Food Service Management', '/admin/food_services'],
                ['Board Books Management', '/admin/board-books'],
                ['Board Minutes Management', '/admin/board-minutes'],
                ['Newsletters Management', '/admin/newsletters'],
                ['Drills Management', '/admin/drills']
              ], current_path),
              class: "p-2",
              onchange: "if(this.value) window.location.href = this.value;"
          end
        end
      end
    end
  end
end