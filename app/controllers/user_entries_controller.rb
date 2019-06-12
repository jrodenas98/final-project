class UserEntriesController < ApplicationController
  def list
    
    
    # Get all of the user's entries
    @user_entries = UserEntry.where(:user_id => current_user.id).order(:created_at => :desc)
    
    
    
    
    #Find the next TLC Prompt to Show User
    latest_TLC_prompt = @user_entries.where(:journal_method_id => "1").order(:created_at => :desc).first
    if latest_TLC_prompt == nil
      @next_TLC_prompt = JournalPrompt.where(:journal_method_id => "1").order(:day => :asc).first
    else
      latest_TLC_prompt_id = latest_TLC_prompt.prompt_id.to_i
      latest_TLC_prompt = JournalPrompt.where(:id => latest_TLC_prompt_id).first
      
      if latest_TLC_prompt.day == "7"
        @next_TLC_prompt = JournalPrompt.where(:journal_method_id => "1").order(:day => :asc).first
      else
        next_TLC_prompt_id = latest_TLC_prompt_id + 1
        @next_TLC_prompt = JournalPrompt.where(:id => next_TLC_prompt_id).first
        
      end
      
    end
    
    #Find the next 3 Act Prompt to Show User
    latest_3Act_prompt = @user_entries.where(:journal_method_id => "2").order(:created_at => :desc).first
    if latest_3Act_prompt == nil
      @next_3Act_prompt = JournalPrompt.where(:journal_method_id => "2").order(:day => :asc).first
    else
      latest_3Act_prompt_id = latest_3Act_prompt.prompt_id.to_i
      latest_3Act_prompt = JournalPrompt.where(:id => latest_3Act_prompt_id).first
      
      if latest_3Act_prompt.day == "7"
        @next_3Act_prompt = JournalPrompt.where(:journal_method_id => "2").order(:day => :asc).first
      else
        next_3Act_prompt_id = latest_3Act_prompt_id + 1
        @next_3Act_prompt = JournalPrompt.where(:id => next_3Act_prompt_id).first
      end
      
    end
    
    #Find the next Goal Prompt to Show User
    latest_Goal_prompt = @user_entries.where(:journal_method_id => "3").order(:created_at => :desc).first
    if latest_Goal_prompt == nil
      @next_Goal_prompt = JournalPrompt.where(:journal_method_id => "3").order(:day => :asc).first
    else
      latest_Goal_prompt_id = latest_Goal_prompt.prompt_id.to_i
      latest_Goal_prompt = JournalPrompt.where(:id => latest_Goal_prompt_id).first
      
      if latest_Goal_prompt.day == "7"
        @next_Goal_prompt = JournalPrompt.where(:journal_method_id => "3").order(:day => :asc).first
      else
        next_Goal_prompt_id = latest_Goal_prompt_id + 1
        @next_Goal_prompt = JournalPrompt.where(:id => next_Goal_prompt_id).first
      end
      
    end
    
    #Find the next Gratitude Prompt to Show User
    latest_Gratitude_prompt = @user_entries.where(:journal_method_id => "4").order(:created_at => :desc).first
    if latest_Gratitude_prompt == nil
      @next_Gratitude_prompt = JournalPrompt.where(:journal_method_id => "4").order(:day => :asc).first
    else
      latest_Gratitude_prompt_id = latest_Gratitude_prompt.prompt_id.to_i
      latest_Gratitude_prompt = JournalPrompt.where(:id => latest_Gratitude_prompt_id).first
      
      if latest_Gratitude_prompt.day == "7"
        @next_Gratitude_prompt = JournalPrompt.where(:journal_method_id => "4").order(:day => :asc).first
      else
        next_Gratitude_prompt_id = latest_Gratitude_prompt_id + 1
        @next_Gratitude_prompt = JournalPrompt.where(:id => next_Gratitude_prompt_id).first
      end
      
    end
    
    #Find the latest Free Write Prompt to Show User (There should only be one)
    freeform_method_id = JournalMethod.where(:name => "Freeform").first.id
    @next_Freeform_prompt = JournalPrompt.where(:journal_method_id => freeform_method_id).first
    
    #@prompts = JournalPrompt.where(:id => @prompt_ids)
    
    
    #Get quote of the day
    require("open-uri")
    quote_url =  open("http://quotes.rest/qod.json?category=inspire&key=xzOAu0zZR6PxT16S6fe1JQeF").read
  
    parsed_quote_result = JSON.parse(quote_url)
    
    quote_contents = parsed_quote_result.fetch("contents")
    
    quote_contents_quotes = quote_contents.fetch("quotes")
    
    quote_contents_quotes_first = quote_contents_quotes.at(0)
    
    @quote_text = quote_contents_quotes_first.fetch("quote")
    @quote_author = quote_contents_quotes_first.fetch("author")
    
    
    render("user_entry_templates/list.html.erb")
  end
  



  def details
    @user_entry = UserEntry.where({ :id => params.fetch("id_to_display") }).first
    @prompt = JournalPrompt.where( :id => @user_entry.prompt_id).first
    @journal_method = JournalMethod.where( :id => @user_entry.journal_method_id).first
    render("user_entry_templates/details.html.erb")
  end

  def blank_form
    @user_entry = UserEntry.new
    @prompt_id = params.fetch("prompt_id")
    @prompt = JournalPrompt.where( :id => @prompt_id).first
    @journal_method = JournalMethod.where( :id => @prompt.journal_method_id).first
    render("user_entry_templates/blank_form.html.erb")
  end

  def save_new_info
    @user_entry = UserEntry.new

    @user_entry.user_id = params.fetch("user_id")
    @user_entry.prompt_id = params.fetch("prompt_id")
    @user_entry.response = params.fetch("response")
    @user_entry.headline = params.fetch("headline")
    @user_entry.journal_method_id = params.fetch("journal_method_id")

    if @user_entry.valid?
      @user_entry.save

      redirect_to("/user_entries", { :notice => "User entry created successfully." })
    else
      render("user_entry_templates/blank_form.html.erb")
    end
  end

  def prefilled_form
    @user_entry = UserEntry.where({ :id => params.fetch("id_to_prefill") }).first
    @prompt = JournalPrompt.where({ :id => @user_entry.prompt_id}).first
    @journal_method = JournalMethod.where( :id => @user_entry.journal_method_id).first
    render("user_entry_templates/prefilled_form.html.erb")
  end

  def save_edits
    @user_entry = UserEntry.where({ :id => params.fetch("id_to_modify") }).first

    @user_entry.user_id = params.fetch("user_id")
    @user_entry.prompt_id = params.fetch("prompt_id")
    @user_entry.response = params.fetch("response")
    @user_entry.headline = params.fetch("headline")
    @user_entry.journal_method_id = params.fetch("journal_method_id")

    if @user_entry.valid?
      @user_entry.save

      redirect_to("/user_entries/" + @user_entry.id.to_s, { :notice => "User entry updated successfully." })
    else
      render("user_entry_templates/prefilled_form.html.erb")
    end
  end

  def remove_row
    @user_entry = UserEntry.where({ :id => params.fetch("id_to_remove") }).first

    @user_entry.destroy

    redirect_to("/user_entries", { :notice => "User entry deleted successfully." })
  end
end
