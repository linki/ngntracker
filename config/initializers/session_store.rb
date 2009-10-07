# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ngntracker_session',
  :secret      => 'af822c385ece199bfb250e5fa7f63ae65e430470b79e5ae079d25201d72411f81970841c22b4b23fae2e63e873d4ebf5019baa9ab7d543e3f88db21d8e5288bb'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
