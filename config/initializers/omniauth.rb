OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['YOUR-APP-ID-HERE'], ENV['YOUR-APP-SECRET-HERE']
end