class CreateConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :conversations, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.uuid :sender_id
      t.uuid :recipient_id
      t.timestamps
    end
    add_foreign_key :conversations, :users, column: :sender_id
    add_foreign_key :conversations, :users, column: :recipient_id
  end
end
