Refinery::Application.routes.draw do
  resources :contacts, :only => [:index, :show]
  
  scope(:path => 'refinery', :as => 'admin', :module => 'admin') do
    resources :contacts do
      resources :notes, :only => [:create, :update]
    end
  end
end
