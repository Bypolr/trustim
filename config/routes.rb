Rails.application.routes.draw do
  # Serve websocket cable resources in-process
  mount ActionCable.server => '/cable'

  root   'static_pages#home'
  get    'help',    to: 'static_pages#help'
  get    'about',   to: 'static_pages#about'
  get    'contact', to: 'static_pages#contact'
  get    'signup',  to: 'users#new'
  get    'login',   to: 'sessions#new'
  post   'login',   to: 'sessions#create'
  delete 'logout',  to: 'sessions#destroy'

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  get 'conversations/:sender_username/:recipient_username', to: 'conversations#show', as: :show_conversation
  post 'conversations/:conversation_id/messages', to: 'messages#create', as: :messages

end
