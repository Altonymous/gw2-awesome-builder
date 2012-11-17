class TrinketsController < ApplicationController
  include SortModule
  include ChildExtractionModule

  # GET /trinkets
  # GET /trinkets.json
  def index
    @sort ||= 'attack_power desc'
    @trinkets = Trinket.includes(:gear_enhancements, :slot).order(@sort).page(params[:page])

    respond_with @trinkets
  end

  # GET /trinkets/1
  # GET /trinkets/1.json
  def show
    @trinket = Trinket.includes(:gear_enhancements, :enhancements).find(params[:id])

    respond_with @trinket
  end

  # GET /trinkets/new
  # GET /trinkets/new.json
  def new
    @trinket = Trinket.new

    respond_with @trinket
  end

  # GET /trinkets/1/edit
  def edit
    @trinket = Trinket.find(params[:id])

    respond_with @trinket
  end

  # POST /trinkets
  # POST /trinkets.json
  def create
    params_gear_enhancements = params[:trinket].delete(:gear_enhancements)
    @trinket = Trinket.create(params[:trinket]) do |trinket|
      hydrate_child_relationship!(trinket, params_gear_enhancements, :gear_enhancements)
    end

    respond_with @trinket
  end

  # PUT /trinkets/1
  # PUT /trinkets/1.json
  def update
    @trinket = Trinket.find(params[:id])

    params_gear_enhancements = params[:trinket].delete(:gear_enhancements)
    hydrate_child_relationship!(@trinket, params_gear_enhancements, :gear_enhancements)

    @trinket.update_attributes(params[:trinket])

    respond_with @trinket
  end

  # DELETE /trinkets/1
  # DELETE /trinkets/1.json
  def destroy
    @trinket = Trinket.destroy(params[:id])

    respond_with @trinket
  end
end
