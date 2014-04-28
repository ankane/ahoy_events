Ahoy::Engine.routes.draw do
  scope module: "ahoy" do
    resources :events, only: [:create]
  end
end
