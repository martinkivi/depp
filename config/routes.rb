Depp::Engine.routes.draw do
  resources :sessions do
    collection do
      post 'pki'
    end
  end

  get '/login/id_card', to: 'sessions#login_id_card', as: 'login_id_card'
  get '/login/m_id', to: 'sessions#login_m_id', as: 'login_m_id'
  get '/login/pki', to: 'sessions#login_pki', as: 'login_pki'
  get '/logout', to: 'sessions#destroy'

  resources :domains do
    collection do
      post 'update', as: 'update'
      post 'destroy', as: 'destroy'
      get 'renew'
      match 'transfer', via: [:post, :get]
      get 'edit'
      get 'info'
      get 'check'
      get 'delete'
    end
  end

  resources :contacts do
    member do
      get 'delete'
    end

    collection do
      get 'check'
    end
  end

  resource :poll do
    collection do
      post 'confirm_keyrelay'
      post 'confirm_transfer'
    end
  end

  resource :keyrelay

  resource :xml_console do
    collection do
      get 'load_xml'
    end
  end

  root 'polls#show'
end
