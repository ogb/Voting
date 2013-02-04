class AddVoterAndCandidateInputToBallot < ActiveRecord::Migration
  def change
    add_column :ballots, :voter_input, :string
    add_column :ballots, :candidate_input, :string
  end
end
