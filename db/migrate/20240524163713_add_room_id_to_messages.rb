class AddRoomIdToMessages < ActiveRecord::Migration[7.1]
  def change
    add_column :messages, :room_id, :integer
  end
end
