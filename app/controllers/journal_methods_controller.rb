class JournalMethodsController < ApplicationController
  def list
    @journal_methods = JournalMethod.all

    render("journal_method_templates/list.html.erb")
  end

  def details
    @journal_method = JournalMethod.where({ :id => params.fetch("id_to_display") }).first

    render("journal_method_templates/details.html.erb")
  end

  def blank_form
    @journal_method = JournalMethod.new

    render("journal_method_templates/blank_form.html.erb")
  end

  def save_new_info
    @journal_method = JournalMethod.new

    @journal_method.name = params.fetch("name")
    @journal_method.description = params.fetch("description")

    if @journal_method.valid?
      @journal_method.save

      redirect_to("/journal_methods", { :notice => "Journal method created successfully." })
    else
      render("journal_method_templates/blank_form.html.erb")
    end
  end

  def prefilled_form
    @journal_method = JournalMethod.where({ :id => params.fetch("id_to_prefill") }).first

    render("journal_method_templates/prefilled_form.html.erb")
  end

  def save_edits
    @journal_method = JournalMethod.where({ :id => params.fetch("id_to_modify") }).first

    @journal_method.name = params.fetch("name")
    @journal_method.description = params.fetch("description")

    if @journal_method.valid?
      @journal_method.save

      redirect_to("/journal_methods/" + @journal_method.id.to_s, { :notice => "Journal method updated successfully." })
    else
      render("journal_method_templates/prefilled_form.html.erb")
    end
  end

  def remove_row
    @journal_method = JournalMethod.where({ :id => params.fetch("id_to_remove") }).first

    @journal_method.destroy

    redirect_to("/journal_methods", { :notice => "Journal method deleted successfully." })
  end
end
