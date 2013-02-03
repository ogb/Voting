class CreateBallotsUsersTable < ActiveRecord::Migration
  def up
	create_table :ballots_users, :id => false do |t|
		t.references :ballot
		t.references :user
	end	
	add_index :ballots_users, [:ballot_id, :user_id]
	add_index :ballots_users, [:user_id, :ballot_id]
  end

  def down
	drop_table :ballots_users
  end
end
