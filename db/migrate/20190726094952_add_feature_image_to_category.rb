class AddFeatureImageToCategory < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :feature_image, :string, null: true
  end
end
