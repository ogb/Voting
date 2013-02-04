class AddPublicResultsToBallots < ActiveRecord::Migration
  def change
	add_column :ballots, :public_results, :boolean
  end
end
