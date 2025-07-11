# config/puma.rb
port ENV.fetch("PORT") { 3009 }
environment ENV.fetch("RACK_ENV") { "production" }
workers 1
threads 1, 5

preload_app!
bind "tcp://0.0.0.0:#{ENV['PORT'] || 3009}"
