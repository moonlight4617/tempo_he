Rails.application.routes.draw do
  root to: 'home#top'
  
  #owner_sessions
  get 'owners/login', to: 'owner_sessions#new', as: 'owner_login'
  post 'owners/login', to: 'owner_sessions#create', as: 'owner_logged_in'
  post 'owners/sample_owner', to: 'owner_sessions#sample_owner', as: 'sample_owner'
  delete 'owners/logout', to: 'owner_sessions#logout', as: 'owner_logout'
  
  #owners
  get 'owners/new', to: 'owners#new', as: 'o_new'
  get 'owners/show', to: 'owners#show', as: 'o_show'
  get 'owners/edit', to: 'owners#edit', as: 'o_edit'
  get 'owners/about', to: 'owners#about', as: 'o_about'
  post 'owners/new', to: 'owners#create', as: 'o_create'
  patch 'owners/edit', to: 'owners#update'
  patch 'owners/delete', to: 'owners#destroy', as: 'o_destroy'
  
  #shops
  get 'shops', to: 'shops#index', as: 's_index'
  get 'shops/new', to: 'shops#new', as: 's_new'
  get 'shops/:id', to: 'shops#show', as: 's_show'
  get 'shops/:id/edit', to: 'shops#edit', as: 's_edit'
  get 'shops/:id/set_business_time', to: 'shops#set_business_time', as: 's_set_business_time'
  get 'shops/:id/reservation_frame', to: 'shops#reservation_frame', as: 's_res'
  get 'shops/:id/next', to: 'shops#next', as: 's_next'
  get 'shops/:id/prev', to: 'shops#prev', as: 's_prev'
  get 'shops/:id/modal_register', to: 'shops#modal_register', as: 's_modal'
  post 'shops/new', to: 'shops#create', as: 's_create'
  post 'shops/zip', to: 'shops#zip'
  post 'shops/:id/set_reservation_frame', to: 'shops#set_reservation_frame', as: 's_set_res'
  post 'shops/:id/set_reservation_day_frame', to: 'shops#set_reservation_day_frame', as: 's_day_res'
  patch 'shops/:id/edit', to: 'shops#update'
  patch 'shops/:id/set_business_time', to: 'shops#update'
  patch 'shops/:id/delete', to: 'shops#destroy', as: 's_destroy'
  delete 'shops/:id/remove_reservation_frame', to: 'shops#remove_reservation_frame', as: 's_remove_res'
  
  # chats
  get 'shops/:id/chats/new', to: 'chats#new', as: 'ch_new' 
  get 'shops/:id/chats/', to: 'chats#show', as: 'ch_show' 
  get 'shops/:id/chats/show_for_ow', to: 'chats#show_for_owner', as: 'ch_show_owner' 
  get 'shops/:id/chats/index', to: 'chats#index_for_owner', as: 'ch_index_owner' 
  post 'shops/:id/chats/msg', to: 'chats#message', as: 'ch_msg' 
  post 'shops/:id/chats/msg_owner', to: 'chats#message_from_shop', as: 'ch_msg_shop' 
  delete 'shops/:id/chats/:id/delete', to: 'chats#destroy', as: 'ch_d' 
  
  # messages
  # get 'shops/:id/messages/index', to: 'messages#index', as: 'm_index' 
  # get 'shops/:id/messages/new', to: 'messages#new', as: 'm_new' 
  # get 'shops/:id/messages/:id', to: 'messages#show', as: 'm_show' 
  # post 'shops/:id/messages/new', to: 'messages#create', as: 'm_create' 
  # delete 'shops/:id/messages/:id/delete', to: 'messages#destroy', as: 'm_destroy' 

  #calendars
  get 'shops/calendars/index', to: 'calendars#index_for_user', as: 'c_index'
  get 'shops/:id/calendars/new', to: 'calendars#new', as: 'c_new'
  get 'shops/:id/calendars/next', to: 'calendars#next', as: 'c_next'
  get 'shops/:id/calendars/prev', to: 'calendars#prev', as: 'c_prev'
  get 'shops/:id/calendars/s_index', to: 'calendars#s_index', as: 'c_s_index'
  get 'shops/:id/calendars/:id/edit', to: 'calendars#edit', as: 'c_edit'
  get 'shops/:id/calendars/confirm', to: 'calendars#confirm', as: 'c_confirm'
  post 'shops/:id/calendars/new', to: 'calendars#create', as: 'c_create'
  patch 'shops/:id/calendars/:id/edit', to: 'calendars#update', as: 'c_update'
  delete 'shops/:id/calendars/:id/delete', to: 'calendars#destroy', as: 'c_destroy'

  #users
  get 'users/new', to: 'users#new', as: 'u_new'
  get 'users/show', to: 'users#show', as: 'u_show'
  get 'users/edit', to: 'users#edit', as: 'u_edit'
  get 'users/about', to: 'users#about', as: 'u_about'
  post 'users/new', to: 'users#create', as: 'u_create'
  patch 'users/edit', to: 'users#update', as: 'u_update'
  patch 'users/destroy', to: 'users#destroy', as: 'u_destroy'

  #user_session
  get 'users/login', to: 'user_sessions#new', as: 'user_login'
  post 'users/login', to: 'user_sessions#create', as: 'user_logged_in'
  post 'users/login_sample', to: 'user_sessions#sample_user', as: 'sample_user'
  delete 'users/logout', to: 'user_sessions#logout', as: 'user_logout'

end
