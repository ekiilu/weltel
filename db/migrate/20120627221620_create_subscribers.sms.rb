# This migration comes from sms (originally 20120610164322)
class CreateSubscribers < ActiveRecord::Migration
  #
  def change
    create_table(:sms_subscribers) do |t|
      t.boolean(:active, :null => false, :default => false)
      t.string(:phone_number, :null => false, :limit => Sms::PHONE_NUMBER_LENGTH)
      t.timestamps
    end

    add_index(:sms_subscribers, :active)
    add_index(:sms_subscribers, :phone_number, :unique => true)
  end
end
