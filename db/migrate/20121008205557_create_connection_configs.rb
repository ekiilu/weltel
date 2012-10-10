class CreateConnectionConfigs < ActiveRecord::Migration
  def change
    create_table(:connection_configs) do |t|
      t.string(:device, :default => '/dev/ttyUSB0')
      t.text(:extra, :default => '')
      t.timestamps
    end
  end
end
