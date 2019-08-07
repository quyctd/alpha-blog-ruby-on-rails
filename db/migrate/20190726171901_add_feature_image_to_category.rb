class AddFeatureImageToCategory < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :image_data, :binary, null: true
    add_column :categories, :image_name, :string, null: true
    add_column :categories, :mime_type, :string, null: true
  end
end
