Rails.application.routes.draw do
  root("user_entries#list")
  

  #------------------------------

  
  #------------------------------

  # Routes for the User entry resource:

  # CREATE
  match("/new_user_entry_form/:prompt_id", { :controller => "user_entries", :action => "blank_form", :via => "get" })
  match("/insert_user_entry_record", { :controller => "user_entries", :action => "save_new_info", :via => "post" })

  # READ
  match("/user_entries", { :controller => "user_entries", :action => "list", :via => "get" })
  match("/user_entries/:id_to_display", { :controller => "user_entries", :action => "details", :via => "get" })

  # UPDATE
  match("/existing_user_entry_form/:id_to_prefill", { :controller => "user_entries", :action => "prefilled_form", :via => "get" })
  match("/update_user_entry_record/:id_to_modify", { :controller => "user_entries", :action => "save_edits", :via => "post" })

  # DELETE
  match("/delete_user_entry/:id_to_remove", { :controller => "user_entries", :action => "remove_row", :via => "get" })

  #------------------------------


  #------------------------------

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
