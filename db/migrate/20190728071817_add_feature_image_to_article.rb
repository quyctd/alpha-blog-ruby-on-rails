class AddFeatureImageToArticle < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :image_data, :binary, null: true
    add_column :articles, :image_name, :string, null: true
    add_column :articles, :mime_type, :string, null: true
  end
end
