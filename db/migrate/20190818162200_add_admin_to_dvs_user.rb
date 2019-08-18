class AddAdminToDvsUser < ActiveRecord::Migration[6.0]
  def change
    add_column :dvs_users, :admin, :boolean, default: false
  end
end
