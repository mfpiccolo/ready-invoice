class InvoicesController < ApplicationController
  before_action :find_pg_invoice, only: [:show]
  # before_action :check_last_modified

  # GET /invoices
  # GET /invoices.json
  def index
    @invoices = current_user.invoices

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @invoices }
    end
  end

  # GET /invoices/1
  def show
    @line_items = @invoice.line_items

    respond_to do |format|
      format.html do
        render :template => 'invoices/pdf.html.erb',
               :layout => 'pdf_layout'
      end

      format.pdf do
        @example_text = "some text"
        render :pdf => "file_name",
               :template => 'invoices/pdf.html.erb',
               :layout => 'pdf_layout',
               :footer => {
                  :center => "Center",
                  :left => "Left",
                  :right => "Right"
                           }
      end
    end
  end


  private

  def find_pg_invoice
    @invoice = current_user.sf_objects.find_by_oid(params[:id])
  end
end
