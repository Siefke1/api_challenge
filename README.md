# README

Ruby / Rails Version:
  3.0.3 / 7.0.3
Added Gems:
  gem 'geocoder'
  gem 'rspec-rails', '~> 5.1', '>= 5.1.2'
  gem 'factory_bot_rails'
  gem 'database_cleaner'
  gem 'pry-byebug', '~> 3.9'
  gem 'active_model_serializers', '~> 0.10.13'
Seeds:
  run rails db:seed
Tests:
  run rspec

Reflection:
  Since this was the first API i wrote, this challenge was quite hard for me.
  I learned a lot through my research and tried my best to follow the most recent
  practizes i could find, not sure if i always succeeded with that.
Thoughts on possible improvements:
  Concerning https requests i'd uncomment '# config.force_ssl = true' in production.rb
  The rescues from exceptions and the whole error handling i suspect can be done in
  a more elegant way. Found a library called dry-validations that seemed interesting for
  this use case, considering reading into it with more time.
Questions:
  In the realtors.json Kirby Mcgahey seems to be located in Gerolzhofen,
  while her coordinates point to Berlin as the given example output does.
  Also the only way i could get a useful response through my requests to
  the endpoint via postman & insomnia was to wrap the keys into quotes.
  Not sure if i just didn't manage to find the right way(?)

  Overall i'd like to thank you, i enjoyed this challenge and managed to understand
  some more things and look forward to discussing it in person.

  L.
