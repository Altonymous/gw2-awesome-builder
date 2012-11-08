class TrinketsController < ApplicationController
  # GET /trinkets
  # GET /trinkets.json
  def index
    @trinkets = Trinket.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @trinkets }
    end
  end

  # GET /trinkets/1
  # GET /trinkets/1.json
  def show
    @trinket = Trinket.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @trinket }
    end
  end

  # GET /trinkets/new
  # GET /trinkets/new.json
  def new
    @trinket = Trinket.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @trinket }
    end
  end

  # GET /trinkets/1/edit
  def edit
    @trinket = Trinket.find(params[:id])
  end

  # POST /trinkets
  # POST /trinkets.json
  def create
    @trinket = Trinket.new(params[:trinket])

    respond_to do |format|
      if @trinket.save
        format.html { redirect_to @trinket, notice: 'Trinket was successfully created.' }
        format.json { render json: @trinket, status: :created, location: @trinket }
      else
        format.html { render action: "new" }
        format.json { render json: @trinket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /trinkets/1
  # PUT /trinkets/1.json
  def update
    @trinket = Trinket.find(params[:id])

    respond_to do |format|
      if @trinket.update_attributes(params[:trinket])
        format.html { redirect_to @trinket, notice: 'Trinket was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @trinket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trinkets/1
  # DELETE /trinkets/1.json
  def destroy
    @trinket = Trinket.find(params[:id])
    @trinket.destroy

    respond_to do |format|
      format.html { redirect_to trinkets_url }
      format.json { head :no_content }
    end
  end
end
