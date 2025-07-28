module ActiveAdmin
  module Views
    class TitleBar < Component
      def build(title, action_items)
        super(title, action_items) # Required to trigger internal setup

        # Now override content
        div class: "custom-title-bar" do
          h2 "🌟 #{title}" # Custom heading
          
          # Optional: manually render action items (e.g., New, Edit)
          if action_items.any?
            div class: "custom-actions" do
              action_items.each do |item|
                text_node active_admin_view_context.link_to(item.name, item.url, class: "action-item")
              end
            end
          end
        end
      end
    end
  end
end
