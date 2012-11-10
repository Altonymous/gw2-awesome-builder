class OutfitsController < ApplicationController
  include SortModule

  # GET /outfits
  # GET /outfits.json
  def index
    @sort ||= 'attack_power desc'
    @outfits = Outfit.includes(:head, :shoulders, :chest, :arms, :legs, :feet).order(@sort).page(params[:page])

    respond_with @outfits
  end

  # GET /outfits/1
  # GET /outfits/1.json
  def show
    @outfit = Outfit.find(params[:id])

    respond_with @outfit
  end

  # GET /outfits/new
  # GET /outfits/new.json
  def new
    @outfit = Outfit.new

    respond_with @outfit
  end

  # GET /outfits/1/edit
  def edit
    @outfit = Outfit.find(params[:id])
  end

  # POST /outfits
  # POST /outfits.json
  def create
    @outfit = Outfit.create(params[:outfit])

    respond_with @outfit
  end

  # PUT /outfits/1
  # PUT /outfits/1.json
  def update
    @outfit = Outfit.find(params[:id])
    @outfit.update_attributes(params[:outfit])

    respond_with @outfit
  end

  # DELETE /outfits/1
  # DELETE /outfits/1.json
  def destroy
    @outfit = Outfit.destroy(params[:id])

    respond_with @outfit
  end
end
