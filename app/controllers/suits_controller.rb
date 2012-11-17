class SuitsController < ApplicationController
  # GET /suits
  # GET /suits.json
  def index
    @suits = Suit.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @suits }
    end
  end

  # GET /suits/1
  # GET /suits/1.json
  def show
    @suit = Suit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @suit }
    end
  end

  # GET /suits/new
  # GET /suits/new.json
  def new
    @suit = Suit.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @suit }
    end
  end

  # GET /suits/1/edit
  def edit
    @suit = Suit.find(params[:id])
  end

  # POST /suits
  # POST /suits.json
  def create
    @suit = Suit.new(params[:suit])

    respond_to do |format|
      if @suit.save
        format.html { redirect_to @suit, notice: 'Suit was successfully created.' }
        format.json { render json: @suit, status: :created, location: @suit }
      else
        format.html { render action: "new" }
        format.json { render json: @suit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /suits/1
  # PUT /suits/1.json
  def update
    @suit = Suit.find(params[:id])

    respond_to do |format|
      if @suit.update_attributes(params[:suit])
        format.html { redirect_to @suit, notice: 'Suit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @suit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /suits/1
  # DELETE /suits/1.json
  def destroy
    @suit = Suit.find(params[:id])
    @suit.destroy

    respond_to do |format|
      format.html { redirect_to suits_url }
      format.json { head :no_content }
    end
  end
end
