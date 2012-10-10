class Gammu::OutboxItem < ActiveRecord::Base
  set_table_name 'outbox'
end
