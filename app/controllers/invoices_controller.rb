class InvoicesController < ApplicationController
  include Databasedotcom::Rails::Controller

  before_filter :set_client

  def set_client
    # databasedotcom-rails (hereafter dbdc-r) requires the presesence of
    # rails_root/config/databasedotcom.yml but the actual auth params
    # can be pulled from (and in this case are) the omni-auth auth hash
    # setup as we login. This ensures that if user A logs in to org FOO
    # he/she can only see records that they have access to.
    @config = {:token => session[:omniauthToken],
              :instance_url => session[:omniauthUrl],
              :refresh_token => session[:omniauthRefresh],
              :version => "27.0"}
    dbdc_client= Databasedotcom::Client.new
    dbdc_client.authenticate(@config)
    self.dbdc_client= dbdc_client
  end

  # GET /invoices
  # GET /invoices.json
  def index
    @invoices = Invoice__c.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @invoices }
    end
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
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

  # GET /invoices/new
  # GET /invoices/new.json
  def new
    @invoice = Invoice__c.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @invoice }
    end
  end

  # GET /invoices/1/edit
  def edit
    @invoice = Invoice__c.find(params[:id])
  end

  # POST /invoices
  # POST /invoices.json
  def create
    @invoice = Invoice__c.new(Invoice__c.coerce_params(params[:invoice]))

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to @invoice, notice: 'Opportunity was successfully created.' }
        format.json { render json: @invoice, status: :created, location: @invoice }
      else
        format.html { render action: "new" }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /invoices/1
  # PUT /invoices/1.json
  def update
    @invoice = Invoice__c.find(params[:id])

    respond_to do |format|
      if @invoice.update_attributes(Invoice.coerce_params(params[:invoice]))
        format.html { redirect_to @invoice, notice: 'Invoice was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    @invoice = Invoice__c.find(params[:id])
    @invoice.destroy

    respond_to do |format|
      format.html { redirect_to invoices_url }
      format.json { head :no_content }
    end
  end
end
