class CreateGammuTables < ActiveRecord::Migration
  def up
    db = YAML.load_file(File.join(Rails.root, 'config', 'database.yml'))[Rails.env]
    puts "Attempting to run db/gammu.mysql on database #{db['database']}"
    `mysql -u #{db['username']} -p#{db['password']} #{db['database']} < db/gammu.mysql`
  end

  def down
    drop_table :daemons
    drop_table :gammu
    drop_table :inbox
    drop_table :outbox
    drop_table :outbox_multipart
    drop_table :pbk
    drop_table :pbk_groups
    drop_table :phones
    drop_table :sentitems
  end
end
