Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "463589924355-d9pqvmo0sg54tqrknb7lfrlrp18qllms.apps.googleusercontent.com", "vhR2Bmv-l5wY7IUvDCzsBIz_",
  {
      hd: 'tamu.edu'
  }
  
end