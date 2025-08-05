ActiveAdmin.register Staff, as: 'Staff', path: "staff" do
  config.clear_action_items!

  sidebar :filters, only: []

  config.filters = false

  permit_params :name, :title, :department, :phone, :email, :profile_image

  controller do
    def create
      super do |success, failure|
        success.html do
          redirect_to collection_path, notice: "Staff created" and return
        end
        failure.html { render :new, status: :unprocessable_entity and return }
      end
    end
    
    def update
      super do |success, failure|
        success.html do
          redirect_to collection_path, notice: "Staff updated" and return
        end
        failure.html { render :edit, status: :unprocessable_entity and return }
      end
    end
  end

  member_action :remove_profile_image, method: :delete do
    resource.profile_image.purge_later if resource.profile_image.attached?
    redirect_back fallback_location: edit_admin_staff_path(resource), notice: "Profile image removed"
  end

  index title: "Staff" do
    selected = params[:department]
    departments = Staff::DEPARTMENTS

    div class: "custom-message" do
      h2 "WPLS Staff Management", class: "staff-management-heading"
      para 'You can view staff by department below by selecting a department from the dropdown menu. The order of staff members can be changed using the provided drag-and-drop sort function. You can edit and delete staff members from this page, and you can create new staff members by clicking the "Create Staff" button below.', class: "staff-management-description"
      button class: "primary-btn" do
        link_to "Create Staff", "/admin/staff/new", class: "text-white"
      end

      div class: "mb-3" do
        form method: :get, action: admin_staff_index_path do
          select_tag :department, options_for_select([ [ "Select a Department", "" ] ] + departments.map { |d| [ d, d ] }, selected), class: "form-select d-inline-block w-auto me-2", onchange: "this.form.submit();"
        end
      end
    end

    staffs = selected.present? ? Staff.where(department: selected) : Staff.all

    if selected.present?
      h2 class: "text-center" do
        "#{selected}"
      end
    end

    div do
      table do
        thead do
          tr do
            th do "" end
            th class: "p-3 text-white" do "Name" end
            th class: "p-3 text-white" do "Title" end
            th class: "p-3 text-white" do "Department" end
            th class: "p-3 text-white" do "Phone" end
            th class: "p-3 text-white" do "Email" end
            th class: "p-3 text-white" do "" end
          end
        end

        tbody do
          staffs.each do |s|
            tr do
              td class: "p-3" do
                span do
                  image_tag("drag_drop_icon.png", alt: "Drag and drop")
                end
              end
              td class: "p-3" do s.name end
              td class: "p-3" do s.title end
              td class: "p-3" do s.department end
              td class: "p-3" do s.phone end
              td class: "p-3" do s.email end
              td class: "p-3 d-flex gap-3 justify-content-end" do
                span { link_to image_tag("edit.png", alt: "Edit"), edit_admin_staff_path(s) }
                span { link_to image_tag("delete.png", alt: "Delete"), admin_staff_path(s), method: :delete, data: { confirm: "Are you sure?" } }
              end
            end
          end
        end
      end
    end
  end

  form do |f|
    div class: "mb-3" do
      h2 "Create New Staff Member", class: "mb-1"
      para "Fill out the form below to create a new staff member to appear on the website.", class: "mb-30"
    end

    f.inputs do
      div class: "d-flex gap-3" do
        div class: "flex-1" do
          f.input :name, input_html: { class: "p-2 mt-2 w-100 border border-1 border-black" }
        end
        div class: "flex-1" do
          f.input :title, input_html: { class: "p-2 mt-2 w-100 border border-1 border-black" }
        end
      end

      div class: "d-flex mt-2" do
        div class: "flex-1" do
          f.input :department, as: :select, collection: Staff::DEPARTMENTS, prompt: "Select Department", include_blank: false, input_html: { class: "p-2 mt-2 w-100 border border-1 border-black" }
        end
      end

      div class: "d-flex gap-3 mt-2" do
        div class: "flex-1" do
          f.input :phone, input_html: { class: "p-2 mt-2 w-100 border border-1 border-black" }
        end
        div class: "flex-1" do
          f.input :email, input_html: { class: "p-2 mt-2 w-100 border border-1 border-black" }
        end
      end
      div class: "mt-3" do
        f.input :profile_image, as: :file, input_html: { class: 'hidden-file-input' }, label: false, hint: begin
          div id: "custom-upload-button", class: "grey-button mt-3 w-200 text-center", style: "cursor: pointer;" do
            "Image Upload"
          end
          if f.object.profile_image.attached?
            image_tag(url_for(f.object.profile_image), class:"origin") +
            tag.br +
            link_to("Remove Image",
                    remove_profile_image_admin_staff_path(f.object),
                    method: :delete,
                    data: { confirm: "Are you sure you want to remove this image?" },
                    class: "button mt-2")
          end
        end
      end
    end
    f.actions do
      f.action :submit, label: "Save", button_html: { class: "primary-btn" }
    end
  end
end
