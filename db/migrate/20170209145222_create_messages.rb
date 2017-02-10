class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.text :body
      t.uuid :user_id, index: true
      t.uuid :conversation_id, index: true
      t.boolean :read, default: false
      t.timestamps
    end
    add_foreign_key :messages, :users
    add_foreign_key :messages, :conversations
  end
end
