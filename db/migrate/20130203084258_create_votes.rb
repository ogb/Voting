class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :value
      t.integer :candidate_id

      t.timestamps
    end
  end
end
