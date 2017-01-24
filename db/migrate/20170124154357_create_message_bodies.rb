class CreateMessageBodies < ActiveRecord::Migration[5.0]
  def change
    create_table :message_bodies, id: :uuid, default: 'gen_random_uuid()' do |t|
    	t.text :body
      t.timestamps
    end
  end
end
