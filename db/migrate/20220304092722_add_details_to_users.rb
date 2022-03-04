class AddDetailsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :username, :string
    add_column :users, :name, :string
    add_column :users, :street_address, :string
    add_column :users, :suburb, :string
    add_column :users, :postcode, :string
    add_column :users, :state, :string
    add_column :users, :phone_number, :string
    add_column :users, :bio, :string
    add_column :users, :tradie, :boolean, default: false
  end
end
