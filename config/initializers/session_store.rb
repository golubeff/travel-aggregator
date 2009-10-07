# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_travel_session',
  :secret      => '5e704b537d8be5dd8e3429dca73b534262e1bfdec5d00f6c70583fbaa916c27d771224f0c1322edaebcfc63292ff4a086000c842d54e20367c822d86ebe8e83e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
