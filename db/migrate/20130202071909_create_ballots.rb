class CreateBallots < ActiveRecord::Migration
  def change
    create_table :ballots do |t|
      t.string :title
      t.string :description
      t.integer :algorithm
      t.integer :type
      t.datetime :end_time

      t.timestamps
    end
  end
end
