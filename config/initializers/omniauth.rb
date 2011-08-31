Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'qvV1ZZtFwzQVD6HGxIQDYw', 'eH6l5bHts6vynptyrgQiJbU2erIYdn9zHTDCoHhzBw'
  # provider :facebook, 'APP_ID', 'APP_SECRET'
  # provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end
