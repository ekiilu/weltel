class CreateResponses < ActiveRecord::Migration
  def change
    create_table(:weltel_responses) do |t|
      t.string(:name, :null => false, :limit => 160)
      t.string(:value, :null => false)
      t.timestamps
    end
    add_index(:weltel_responses, :name, :unique => true)
  end
end
