module GoogleDrive
  def self.load_session
    oauth = GoogleOauth2Client.oauth2_client(refresh_token: ENV.fetch("GOOGLE_REFRESH_TOKEN", "")))
    session = GoogleDrive::Session.from_credentials(oauth)
    return session
  end
end