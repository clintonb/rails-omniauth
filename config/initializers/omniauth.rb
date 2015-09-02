Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, Rails.application.secrets.omniauth_provider_key, Rails.application.secrets.omniauth_provider_secret
  provider :openid_connect, {
                              name: :edx,
                              scope: [:openid, :email, :profile],
                              response_type: :code,
                              issuer: 'https://courses.stage.edx.org/oauth2',
                              client_signing_alg: :HS256,
                              send_nonce: false,
                              client_options: {
                                  port: 443,
                                  scheme: 'https',
                                  host: 'courses.stage.edx.org',
                                  identifier: 'CLIENT-ID',
                                  secret: 'CLIENT-SECRET',
                                  redirect_uri: 'http://localhost:3000/auth/edx/callback',
                                  authorization_endpoint: '/oauth2/authorize/',
                                  token_endpoint: '/oauth2/access_token/',
                                  userinfo_endpoint: '/oauth2/user_info/',
                              },
                          }
end
