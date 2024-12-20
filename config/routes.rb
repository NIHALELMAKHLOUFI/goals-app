Rails.application.routes.draw do
  resources :goals do
    resources :steps
  end
end
