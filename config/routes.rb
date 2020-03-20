Rails.application.routes.draw do

  # Routes for the Okay resource:

  # CREATE
  match("/insert_okay", { :controller => "okays", :action => "create", :via => "post"})
          
  # READ
  match("/okays", { :controller => "okays", :action => "index", :via => "get"})
  
  match("/okays/:id_from_path", { :controller => "okays", :action => "show", :via => "get"})
  
  # UPDATE
  
  match("/modify_okay/:id_from_path", { :controller => "okays", :action => "update", :via => "post"})
  
  # DELETE
  match("/delete_okay/:id_from_path", { :controller => "okays", :action => "destroy", :via => "get"})

  #------------------------------

  # Routes for the Follow request resource:

  # CREATE
  match("/insert_follow_request", { :controller => "follow_requests", :action => "create", :via => "post"})
          
  # READ
  match("/follow_requests", { :controller => "follow_requests", :action => "index", :via => "get"})
  
  match("/follow_requests/:id_from_path", { :controller => "follow_requests", :action => "show", :via => "get"})
  

  get("/my_follow_requests/:username", { :controller => "follow_requests", :action => "show_my_followers"})

  get("/people_i_follow/:username", { :controller => "follow_requests", :action => "show_people_i_follow"})

  # UPDATE
  
  match("/modify_follow_request/:id_from_path", { :controller => "follow_requests", :action => "update", :via => "post"})
  
  # DELETE
  match("/delete_follow_request/:id_from_path", { :controller => "follow_requests", :action => "destroy", :via => "get"})

  #------------------------------

  get("/", { :controller => "users", :action => "index" })
  get("/users", { :controller => "users", :action => "index" })

  get("/users/:the_username", {:controller => "users", :action => "show"})


  # Routes for signing up

  match("/user_sign_up", { :controller => "users", :action => "new_registration_form", :via => "get"})
  
  # Routes for signing in
  match("/user_sign_in", { :controller => "user_sessions", :action => "new_session_form", :via => "get"})
  
  match("/user_verify_credentials", { :controller => "user_sessions", :action => "add_cookie", :via => "post"})
  
  # Route for signing out
  
  match("/user_sign_out", { :controller => "user_sessions", :action => "remove_cookies", :via => "get"})
  
  # Route for creating account into database 

  match("/post_user", { :controller => "users", :action => "create", :via => "post" })
  
  # Route for editing account
  
  match("/edit_user", { :controller => "users", :action => "edit_registration_form", :via => "get"})
  
  match("/patch_user", { :controller => "users", :action => "update", :via => "post"})
  
  # Route for removing an account
  
  match("/cancel_user_account", { :controller => "users", :action => "destroy", :via => "get"})


  #------------------------------

  # ======= Add Your Routes Above These =============
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
