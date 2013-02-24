# Backup Weltel

This guide uses the [backup gem](https://github.com/meskyanichi/backup) (```gem install backup```) and Dropbox. The gem makes backing up the weltel SQL database very easy.

### Install Dropbox

You need to install [Dropbox](http://www.dropbox.com) on your system and then create a [Developer App](http://developer.dropbox.com).

### Create a Backup Model

This has already been done with the following:

```backup generate:model --trigger sql_backup --databases='mysql' --storages='dropbox' --compressors='gzip' --encryptors='openssl'```

The generated files have been moved to ```/backup``` in the Weltel app. **Add your Dropbox API key/secret to the model file.**

### Creating the first backup

From the backup gem wiki:

> **FOR YOUR INFORMATION** you must run your backup to Dropbox manually the first time to authorize your machine with your Dropbox account. When you manually run your backup, backup will provide you with a URL which you must visit with your browser. Once you've authorized your machine, Backup will write out the session to a cache file and from there on Backup will use the cache file and won't prompt you to manually authorize, meaning you can run it in the background as normal using for example a Cron task.

To create a backup, run the following from the app root folder:

```backup perform --trigger sql_backup --root-path data```

Once you have completed this action, you can create a scheduled backup. Uncomment the event on schedule.rb.