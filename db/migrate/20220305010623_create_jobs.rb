class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :street_address, null: false
      t.string :suburb, null: false
      t.string :postcode, null: false
      t.string :state, null: false
      t.float :price
      t.integer :status, default: 0
      t.boolean :successful
      t.boolean :paid_on_time
      t.integer :payment_terms, default: 7
      t.references :tradie
      t.references :homeowner

      t.timestamps
    end
    add_foreign_key :jobs, :users, column: :tradie_id
    add_foreign_key :jobs, :users, column: :homeowner_id
  end
end
