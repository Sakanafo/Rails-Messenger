class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.integer :user_id

      t.foreign_key :users, column: :user_id, on_delete: :nullify

      t.timestamps
    end
  end
end
