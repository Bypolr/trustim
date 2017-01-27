class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages, id: :uuid, default: 'gen_random_uuid()' do |t|
    	t.uuid :user_id, index: true
    	t.uuid :chatroom_id, index: true
    	t.text :body, null: false
      t.timestamps
    end
    add_foreign_key :messages, :users
    add_foreign_key :messages, :chatrooms
  end
end
