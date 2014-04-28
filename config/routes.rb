Rails.application.routes.draw do
  mount AhoyEvents::Engine => "/ahoy"
end

AhoyEvents::Engine.routes.draw do
  scope module: "ahoy" do
    resources :events, only: [:create]
  end
end
