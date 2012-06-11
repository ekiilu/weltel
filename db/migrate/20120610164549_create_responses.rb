class CreateResponses < ActiveRecord::Migration
  def change
    create_table(:responses) do |t|
      t.string(:name, :null => false, :limit => 160)
      t.integer(:value, :null => false, :default => 1)
      t.timestamps
    end
    add_index(:responses, :name, :unique => true)
  end
end

    # properties
    #property(:id, Serial)
    #property(:name, String, {:unique => true, :required => true, :length => 160})
    #property(:value, Enum[:positive, :negative], {:index => true, :required => true, :default => :positive})
    #property(:created_at, DateTime)
    #property(:updated_at, DateTime)
