class OutfitsController < ApplicationController
  include SortModule

  def index
    @sort ||= 'attack_power desc'
    @outfits = Outfit.includes(:helm, :shoulders, :coat, :gloves, :legs, :boots).order(@sort).page(params[:page])

    respond_with @outfits
  end

  def show
    @outfit = Outfit.find(params[:id])

    respond_with @outfit
  end

  def new
    @outfit = Outfit.new

    respond_with @outfit
  end

  def edit
    @outfit = Outfit.find(params[:id])
  end

  def create
    @outfit = Outfit.create(params[:outfit])

    respond_with @outfit
  end

  def update
    @outfit = Outfit.find(params[:id])
    @outfit.update_attributes(params[:outfit])

    respond_with @outfit
  end

  def destroy
    @outfit = Outfit.destroy(params[:id])

    respond_with @outfit
  end
end
