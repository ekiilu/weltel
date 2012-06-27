# This migration comes from sms (originally 20120610164323)
class CreateMessages < ActiveRecord::Migration
  #
  def change
    create_table(:sms_messages) do |t|
    	t.references(:subscriber)
    	t.references(:parent)
    	t.enum(:status, :null => false)
      t.string(:phone_number, {:null => false, :limit => Sms::PHONE_NUMBER_LENGTH})
      t.string(:body, :limit => Sms::MESSAGE_BODY_MAX)
      t.string(:sid, :limit => Sms::MESSAGE_SID_LENGTH)
      t.timestamps
    end

    add_index(:sms_messages, :status)
    add_index(:sms_messages, :phone_number)
    add_index(:sms_messages, :sid)
  end
end
