class CreateVotesUsersTable < ActiveRecord::Migration
  def up
    create_table :votes_users, :id= => false do |t|
      t.references :vote
      t.references :user
    end
    add_index :votes_users, [:vote_id, :user_id]
    add_index :votes_users, [:user_id, :vote_id]
  end

  def down
    drop_table :votes_users
  end
end
