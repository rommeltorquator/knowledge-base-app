class AddSlugToProcedures < ActiveRecord::Migration[6.0]
  def change
    add_column :procedures, :slug, :string
    add_index :procedures, :slug, unique: true
  end
end
