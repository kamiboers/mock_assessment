class AddUserIdToLinks < ActiveRecord::Migration
  def change
    add_column :links, :user_id, :integer, references: :users
  end
end
