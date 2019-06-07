class JournalPromptsController < ApplicationController
  def list
    @journal_prompts = JournalPrompt.all

    render("journal_prompt_templates/list.html.erb")
  end

  def details
    @journal_prompt = JournalPrompt.where({ :id => params.fetch("id_to_display") }).first

    render("journal_prompt_templates/details.html.erb")
  end

  def blank_form
    @journal_prompt = JournalPrompt.new

    render("journal_prompt_templates/blank_form.html.erb")
  end

  def save_new_info
    @journal_prompt = JournalPrompt.new

    @journal_prompt.prompt_text = params.fetch("prompt_text")
    @journal_prompt.day = params.fetch("day")
    @journal_prompt.journal_method_id = params.fetch("journal_method_id")

    if @journal_prompt.valid?
      @journal_prompt.save

      redirect_to("/journal_prompts", { :notice => "Journal prompt created successfully." })
    else
      render("journal_prompt_templates/blank_form.html.erb")
    end
  end

  def prefilled_form
    @journal_prompt = JournalPrompt.where({ :id => params.fetch("id_to_prefill") }).first

    render("journal_prompt_templates/prefilled_form.html.erb")
  end

  def save_edits
    @journal_prompt = JournalPrompt.where({ :id => params.fetch("id_to_modify") }).first

    @journal_prompt.prompt_text = params.fetch("prompt_text")
    @journal_prompt.day = params.fetch("day")
    @journal_prompt.journal_method_id = params.fetch("journal_method_id")

    if @journal_prompt.valid?
      @journal_prompt.save

      redirect_to("/journal_prompts/" + @journal_prompt.id.to_s, { :notice => "Journal prompt updated successfully." })
    else
      render("journal_prompt_templates/prefilled_form.html.erb")
    end
  end

  def remove_row
    @journal_prompt = JournalPrompt.where({ :id => params.fetch("id_to_remove") }).first

    @journal_prompt.destroy

    redirect_to("/journal_prompts", { :notice => "Journal prompt deleted successfully." })
  end
end
