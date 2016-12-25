Rails.application.routes.draw do
  root to: "pages#home"
  get 'about', to: 'pages#about'
  resources :contacts, only: :create
  #this is a custom url; was previously /contacts/new
  get 'contact-us', to: 'contacts#new', as: 'new_contact'
end
