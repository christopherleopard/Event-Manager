class CreatePdfDocuments < ActiveRecord::Migration[8.0]
  def change
    create_table :pdf_documents do |t|
      t.string :page_title
      t.string :title

      t.timestamps
    end
  end
end
