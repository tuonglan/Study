# See http://docs.chef.io/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "tuonglan"
client_key               "#{current_dir}/tuonglan.pem"
validation_client_name   "ridh-validator"
validation_key           "#{current_dir}/ridh-validator.pem"
chef_server_url          "https://api.chef.io/organizations/ridh"
cookbook_path            ["#{current_dir}/../cookbooks"]
