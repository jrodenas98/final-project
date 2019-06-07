Rails.application.routes.draw do
  root("user_entries#list")
  # Routes for the Journal method resource:
  
  # CREATE
  match("/new_journal_method_form", { :controller => "journal_methods", :action => "blank_form", :via => "get" })
  match("/insert_journal_method_record", { :controller => "journal_methods", :action => "save_new_info", :via => "post" })

  # READ
  match("/journal_methods", { :controller => "journal_methods", :action => "list", :via => "get" })
  match("/journal_methods/:id_to_display", { :controller => "journal_methods", :action => "details", :via => "get" })

  # UPDATE
  match("/existing_journal_method_form/:id_to_prefill", { :controller => "journal_methods", :action => "prefilled_form", :via => "get" })
  match("/update_journal_method_record/:id_to_modify", { :controller => "journal_methods", :action => "save_edits", :via => "post" })

  # DELETE
  match("/delete_journal_method/:id_to_remove", { :controller => "journal_methods", :action => "remove_row", :via => "get" })

  #------------------------------

  # Routes for the Quote resource:

  # CREATE
  match("/new_quote_form", { :controller => "quotes", :action => "blank_form", :via => "get" })
  match("/insert_quote_record", { :controller => "quotes", :action => "save_new_info", :via => "post" })

  # READ
  match("/quotes", { :controller => "quotes", :action => "list", :via => "get" })
  match("/quotes/:id_to_display", { :controller => "quotes", :action => "details", :via => "get" })

  # UPDATE
  match("/existing_quote_form/:id_to_prefill", { :controller => "quotes", :action => "prefilled_form", :via => "get" })
  match("/update_quote_record/:id_to_modify", { :controller => "quotes", :action => "save_edits", :via => "post" })

  # DELETE
  match("/delete_quote/:id_to_remove", { :controller => "quotes", :action => "remove_row", :via => "get" })

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

  # Routes for the Journal prompt resource:

  # CREATE
  match("/new_journal_prompt_form", { :controller => "journal_prompts", :action => "blank_form", :via => "get" })
  match("/insert_journal_prompt_record", { :controller => "journal_prompts", :action => "save_new_info", :via => "post" })

  # READ
  match("/journal_prompts", { :controller => "journal_prompts", :action => "list", :via => "get" })
  match("/journal_prompts/:id_to_display", { :controller => "journal_prompts", :action => "details", :via => "get" })

  # UPDATE
  match("/existing_journal_prompt_form/:id_to_prefill", { :controller => "journal_prompts", :action => "prefilled_form", :via => "get" })
  match("/update_journal_prompt_record/:id_to_modify", { :controller => "journal_prompts", :action => "save_edits", :via => "post" })

  # DELETE
  match("/delete_journal_prompt/:id_to_remove", { :controller => "journal_prompts", :action => "remove_row", :via => "get" })

  #------------------------------

  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
