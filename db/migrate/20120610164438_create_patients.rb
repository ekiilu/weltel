class CreatePatients < ActiveRecord::Migration
  def change
    create_table(:patients) do |t|
      t.boolean(:system, :null => false, :default => false)
      t.string(:user_name, :null => false, :limit => 32)
      t.string(:study_number, :null => false, :limit => 32)
      t.string(:contact_phone_number, :null => false, :length => 10)
      t.timestamps
    end
  end
end
