class OutfitsController < ApplicationController
  include SortModule

  def index
    @sort ||= 'attack_power desc'
    @outfits = Outfit.order(@sort).page(params[:page])

    respond_with @outfits
  end

  def show
    @outfit = Outfit.includes(:suit, :jewelry).find(params[:id])

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
    armors = params[:outfit].delete(:armors)

    @outfit = Outfit.find(params[:id])
    @outfit.armors = armors.map! { |armor| Armor.find(armor[:id]) } unless armors.blank?
    @outfit.update_attributes(params[:outfit])

    respond_with @outfit
  end

  def destroy
    @outfit = Outfit.destroy(params[:id])

    respond_with @outfit
  end
end
