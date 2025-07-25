AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
NewsletterSetting.first_or_create
FoodService::SCHOOLS.each do |school|
  FoodService.find_or_create_by!(school: school)
end
