class CreateResults < ActiveRecord::Migration
  def change
    create_table(:weltel_results) do |t|
    	t.references(:checkup, :null => false)
    	t.references(:user, :null => false)
    	t.boolean(:initial, :null => false, :default => true)
      t.boolean(:current, :null => false, :default => true)
      t.enum(:value, :null => false)
      t.datetime(:created_at, :null => false)
    end

		add_index(:weltel_results, :checkup_id)
		add_index(:weltel_results, :user_id)
		add_index(:weltel_results, :initial)
    add_index(:weltel_results, :current)
  end
end
