class AddTeamToNewsfeed < ActiveRecord::Migration[6.0]
  def change
    add_reference :newsfeeds, :team, null: false, foreign_key: true
  end
end
