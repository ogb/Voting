class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :title
      t.integer :value

      t.timestamps
    end
  end
end
