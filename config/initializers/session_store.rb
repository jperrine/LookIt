# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_LookIt_session',
  :secret      => '25319cb041b78e7ce111e037da8fdc6632f5160deaa09bc8d8f05122f92f62943fb99114cf8d7362f73919b9a642c2e48a91796478b9f170ee9d6137f052fc8e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
ActionController::Base.session_store = :active_record_store
