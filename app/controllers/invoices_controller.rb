class InvoicesController < ApplicationController
  before_action :find_pg_invoice, only: [:show]
  # before_action :check_last_modified

  # GET /invoices
  # GET /invoices.json
  def index
    @invoices = current_user.invoices.paginate(page: params[:page], per_page: 10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @invoices }
    end
  end

  # GET /invoices/1
  def show
    # Need this because oid could be duplicate from salesforce
    @line_items = @invoice.line_items.where(user_id: current_user.id)

    gon.rc_attrs = RightClickAttrs.(current_user.id, @invoice.id)

    gon.invoice = @invoice.as_json

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

  def update_template
    current_user.layout.update_from_right_click(params[:model_attribute])

    @invoice = FindInvoice.(params[:invoice_id], current_user)
    respond_to do |format|
      format.js
    end
  end


  private

  def find_pg_invoice
    @invoice = FindInvoice.(params[:id], current_user.id)
  end
end
