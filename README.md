Depp
====

EPP/REPP Rails engine

Installation
------------

Add Depp to your Gemfile:

    gem 'depp', github: 'domify/depp'

Mount Depp to your application routes, example:

    mount Depp::Engine, at: '/depp'

Depp requires login_url helper, example in routes:

    get '/login', to: 'sessions#login', as: 'login'

Depp requires current_user helper in controller
