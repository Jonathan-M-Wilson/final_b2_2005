Rails.application.routes.draw do
  get "/flights/:id", to: 'flights#show'
  get "/passengers/:id", to: "passengers#show"
  post "passengers/:passenger_id/passenger_flights", to: "passenger_flights#create"
end
