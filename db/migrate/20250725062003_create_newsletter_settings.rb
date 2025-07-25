class CreateNewsletterSettings < ActiveRecord::Migration[8.0]
  def change
    create_table :newsletter_settings do |t|
      t.string :ecc_url
      t.string :gltw_url
      t.string :wles_url
      t.string :wlms_hs_url
      t.string :district_url

      t.timestamps
    end
  end
end
