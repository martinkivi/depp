Depp
====

EPP/REPP Rails engine, what provides EPP/REPP client functionality for EPP-web-client
under the hood.

Depp initial idea was to provide library for Registrars in order to help them
to implement EPP/REPP clients.

Depp initial idea is currently OFFICIALLY NOT SUPPORTED and there is no
date or promise to support it at the moment. However if desired, you are welcome to fork it.

Currently only EPP-web-client is using it.

Installation
------------

Add Depp and epp to your Gemfile:

    gem 'depp', github: 'domify/depp'
    gem 'epp', '~> 1.4.2', github: 'gitlabeu/epp'

Mount Depp to your application routes, example:

    mount Depp::Engine, at: '/depp'

Depp requires login_url helper, example in routes:

    get '/login', to: 'sessions#login', as: 'login'

Depp requires current_user helper in controller

