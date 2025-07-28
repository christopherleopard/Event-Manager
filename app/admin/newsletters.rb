ActiveAdmin.register_page "Newsletters" do
  menu priority: 2, label: "Newsletters"

  content title: false do
    render "admin/dropdown"
    setting = NewsletterSetting.first_or_create

    div do
      render partial: "admin/newsletters/form", locals: { setting: setting }
    end
  end

  page_action :update, method: :post do
    setting = NewsletterSetting.first_or_create
    field = params[:field]

    if field.present? && setting.update(field => params[:newsletter_setting][field])
      redirect_to admin_newsletters_path, notice: "#{field.to_s.humanize} updated successfully."
    else
      redirect_to admin_newsletters_path, alert: "Update failed."
    end
  end
end
