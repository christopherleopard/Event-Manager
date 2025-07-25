AdminUser.create!(email: 'mpetriella@ignitexds.com', password: 'mpetriella123', password_confirmation: 'mpetriella123')
NewsletterSetting.first_or_create
FoodService::SCHOOLS.each do |school|
  FoodService.find_or_create_by!(school: school)
end
