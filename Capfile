load 'deploy' if respond_to?(:namespace) # cap2 differentiator
Dir['lib/recipes/*.rb', 'vendor/gems/*/recipes/*.rb','vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy'
load 'deploy/assets'