SS::Application.routes.draw do
  Gws::Initializer

  concern :deletion do
    get :delete, on: :member
    delete action: :destroy_all, :on => :collection
  end

  get '.g:site/', to: 'gws/portal#index', as: :gws_portal

  namespace "gws", path: ".g:site/gws" do
    resource  :site
    resources :groups, concerns: [:deletion]
    resources :custom_groups, concerns: [:deletion] do
      resources :members, controller: "custom_groups/members", concerns: [:deletion]
    end
    resources :users, concerns: [:deletion]
    resources :user_titles, concerns: [:deletion]
    resources :roles, concerns: [:deletion]
    resources :facilities, concerns: [:deletion]
    resources :notices, concerns: [:deletion]
    resources :public_notices, only: [:index, :show]
    resources :links, concerns: [:deletion]
    resources :public_links, only: [:index, :show]

    namespace "apis" do
      get "groups" => "groups#index"
      get "users" => "users#index"

      resources :files, concerns: :deletion do
        get :select, on: :member
        get :view, on: :member
        get :thumb, on: :member
        get :download, on: :member
      end
    end
  end
end
