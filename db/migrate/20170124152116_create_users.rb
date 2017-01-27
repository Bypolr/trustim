class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users, id: :uuid, default: 'gen_random_uuid()' do |t|
      t.string :username, limit: 50, null: false
      t.string :password, limit: 50, null: false
      t.string :email, limit: 100, null: false
      t.timestamps
    end
  end
end
