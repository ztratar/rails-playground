class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.integer :event
      t.string :session_id

      t.timestamps
    end
  end
end
