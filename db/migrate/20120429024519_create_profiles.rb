class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.text :about
      t.string :city
      t.string :state
      t.string :country
      t.string :zipcode
      t.timestamp :created_at
      t.timestamp :updated_at

      t.timestamps
    end
  end
end
