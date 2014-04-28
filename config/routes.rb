Rails.application.routes.draw do
  mount AhoyEvents::Engine => "/ahoy"
end

AhoyEvents::Engine.routes.draw do
  resources :events, only: [:create]
end
