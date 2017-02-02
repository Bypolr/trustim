class ChangeUserEmailLengthLimit < ActiveRecord::Migration[5.0]
  def change
  	change_column :users, :email, :string, limit: 256
  end
end
