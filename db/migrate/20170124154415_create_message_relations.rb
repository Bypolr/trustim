class CreateMessageRelations < ActiveRecord::Migration[5.0]
  def change
    create_table :message_relations, id: :uuid, default: 'gen_random_uuid()' do |t|
    	t.serial :serialid
    	t.uuid :sender_id
    	t.uuid :receiver_id
    	t.uuid :body_id
      t.timestamps
    end

    add_foreign_key :message_relations, :users, column: :sender_id
    add_foreign_key :message_relations, :users, column: :receiver_id
    add_foreign_key :message_relations, :message_bodies, column: :body_id
  end
end
