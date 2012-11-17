class JewelriesController < ApplicationController
  # GET /jewelries
  # GET /jewelries.json
  def index
    @jewelries = Jewelry.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @jewelries }
    end
  end

  # GET /jewelries/1
  # GET /jewelries/1.json
  def show
    @jewelry = Jewelry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @jewelry }
    end
  end

  # GET /jewelries/new
  # GET /jewelries/new.json
  def new
    @jewelry = Jewelry.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @jewelry }
    end
  end

  # GET /jewelries/1/edit
  def edit
    @jewelry = Jewelry.find(params[:id])
  end

  # POST /jewelries
  # POST /jewelries.json
  def create
    @jewelry = Jewelry.new(params[:jewelry])

    respond_to do |format|
      if @jewelry.save
        format.html { redirect_to @jewelry, notice: 'Jewelry was successfully created.' }
        format.json { render json: @jewelry, status: :created, location: @jewelry }
      else
        format.html { render action: "new" }
        format.json { render json: @jewelry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /jewelries/1
  # PUT /jewelries/1.json
  def update
    @jewelry = Jewelry.find(params[:id])

    respond_to do |format|
      if @jewelry.update_attributes(params[:jewelry])
        format.html { redirect_to @jewelry, notice: 'Jewelry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @jewelry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jewelries/1
  # DELETE /jewelries/1.json
  def destroy
    @jewelry = Jewelry.find(params[:id])
    @jewelry.destroy

    respond_to do |format|
      format.html { redirect_to jewelries_url }
      format.json { head :no_content }
    end
  end
end
