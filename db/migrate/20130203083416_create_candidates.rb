class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :title
      t.string :description
      t.integer :ballot_id

      t.timestamps
    end
  end
end
