class AddTeamToProcedure < ActiveRecord::Migration[6.0]
  def change
    add_reference :procedures, :team, null: false, foreign_key: true
  end
end
