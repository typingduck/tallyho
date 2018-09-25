Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "TODO...", "TODO..."
  provider :google_oauth2, "TODO...", "TODO..."
  provider :twitter, "TODO...", "TODO..."
end
