class CreateChatrooms < ActiveRecord::Migration[5.0]
  def change
    create_table :chatrooms, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :name, null: false
      t.timestamps
    end
  end
end
