class QuotesController < ApplicationController
  def list
    @quotes = Quote.all

    render("quote_templates/list.html.erb")
  end

  def details
    @quote = Quote.where({ :id => params.fetch("id_to_display") }).first

    render("quote_templates/details.html.erb")
  end

  def blank_form
    @quote = Quote.new

    render("quote_templates/blank_form.html.erb")
  end

  def save_new_info
    @quote = Quote.new

    @quote.body = params.fetch("body")
    @quote.author = params.fetch("author")

    if @quote.valid?
      @quote.save

      redirect_to("/quotes", { :notice => "Quote created successfully." })
    else
      render("quote_templates/blank_form.html.erb")
    end
  end

  def prefilled_form
    @quote = Quote.where({ :id => params.fetch("id_to_prefill") }).first

    render("quote_templates/prefilled_form.html.erb")
  end

  def save_edits
    @quote = Quote.where({ :id => params.fetch("id_to_modify") }).first

    @quote.body = params.fetch("body")
    @quote.author = params.fetch("author")

    if @quote.valid?
      @quote.save

      redirect_to("/quotes/" + @quote.id.to_s, { :notice => "Quote updated successfully." })
    else
      render("quote_templates/prefilled_form.html.erb")
    end
  end

  def remove_row
    @quote = Quote.where({ :id => params.fetch("id_to_remove") }).first

    @quote.destroy

    redirect_to("/quotes", { :notice => "Quote deleted successfully." })
  end
end
