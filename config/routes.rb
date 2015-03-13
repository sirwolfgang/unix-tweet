Rails.application.routes.draw do

  post 'auth/callback', controller: 'authentication', action: 'callback'
  get 'auth/callback', controller: 'authentication', action: 'callback'
  get 'auth/:provider', controller: 'authentication', action: 'oauth', as: :auth_at_provider
  
end
