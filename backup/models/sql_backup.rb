# encoding: utf-8

##
# Backup Generated: sql_backup
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t sql_backup [-c <path_to_configuration_file>]
#
Backup::Model.new(:sql_backup, 'Weltel Backup') do
  ##
  # Split [Splitter]
  #
  # Split the backup file in to chunks of 250 megabytes
  # if the backup file size exceeds 250 megabytes
  #
  split_into_chunks_of 250

  ##
  # MySQL [Database]
  #
  database MySQL do |db|
    # To dump all databases, set `db.name = :all` (or leave blank)
    db.name               = "weltel_dev"
    db.username           = "root"
    db.password           = "password"
    db.host               = "localhost"
    db.port               = 3306
    db.socket             = "/tmp/mysql.sock"
    # Note: when using `skip_tables` with the `db.name = :all` option,
    # table names should be prefixed with a database name.
    # e.g. ["db_name.table_to_skip", ...]
    # db.skip_tables        = []
    # db.only_tables        = ["only", "these" "tables"]
    db.additional_options = ["--quick", "--single-transaction"]
    # Optional: Use to set the location of this utility
    #   if it cannot be found by name in your $PATH
    # db.mysqldump_utility = "/opt/local/bin/mysqldump"
  end

  ##
  # Dropbox File Hosting Service [Storage]
  #
  # Access Type:
  #
  #  - :app_folder (Default)
  #  - :dropbox
  #
  # Note:
  #
  #  Initial backup must be performed manually to authorize
  #  this machine with your Dropbox account.
  #
  store_with Dropbox do |db|
    db.api_key     = "" # Required
    db.api_secret  = "" # Required
    db.access_type = :app_folder
    db.path        = "data"
    db.keep        = 25
  end

  ##
  # Gzip [Compressor]
  #
  compress_with Gzip

end
