class CreateUserRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :user_rooms do |t|
      t.integer :user_id
      t.integer :room_id
      t.boolean :notification

      t.timestamps
    end
  end
end
