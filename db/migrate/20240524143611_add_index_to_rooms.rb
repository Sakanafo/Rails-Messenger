class AddIndexToRooms < ActiveRecord::Migration[7.1]
  def change
    add_index :rooms, :user_id
  end
end
