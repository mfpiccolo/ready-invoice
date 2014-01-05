class InvoicesController < ApplicationController

  before_action :set_pg_constants, only: [:show, :index]
  before_action :find_pg_invoice, only: [:show]

  # GET /invoices
  # GET /invoices.json
  def index
    @invoices = PG::Invoice__c.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @invoices }
    end
  end

  # GET /invoices/1
  def show
    @line_items = PG::Line_Item__c.where("Invoice__c" => @invoice.Id )
    merchandise_ids = @line_items.map(&:Merchandise__c)
    @merchandise = PG::Merchandise__c.where("Id" => merchandise_ids)

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

  def set_pg_constants
    current_user.salesforce.sf_models.each { |m| m.reload }
  end

  def find_pg_invoice
    @invoice = PG::Invoice__c.find(params[:id])
  end
end
