class JewelriesController < ApplicationController
  include SortModule
  include ChildExtractionModule

  # GET /jewelries
  # GET /jewelries.json
  def index
    @sort ||= 'attack_power desc'
    @jewelries = Jewelry.order(@sort).page(params[:page])

    respond_with @jewelries
  end

  # GET /jewelries/1
  # GET /jewelries/1.json
  def show
    @jewelry = Jewelry.includes(:trinkets).find(params[:id])

    respond_with @jewelry
  end

  # GET /jewelries/new
  # GET /jewelries/new.json
  def new
    @jewelry = Jewelry.new

    respond_with @jewelry
  end

  # GET /jewelries/1/edit
  def edit
    @jewelry = Jewelry.find(params[:id])

    respond_with @jewelry
  end

  # POST /jewelries
  # POST /jewelries.json
  def create
    params_trinkets = params[:jewelry].delete(:trinkets)
    @jewelry = Jewelry.create(params[:jewelry]) do |jewelry|
      hydrate_children!(jewelry, params_trinkets, :trinkets, Trinket)
    end

    respond_with @jewelry
  end

  # PUT /jewelries/1
  # PUT /jewelries/1.json
  def update
    @jewelry = Jewelry.find(params[:id])

    params_trinkets = params[:jewelry].delete(:trinkets)
    hydrate_children!(@jewelry, params_trinkets, :trinkets, Trinket)

    @jewelry.update_attributes(params[:jewelry])

    respond_with @jewelry
  end

  # DELETE /jewelries/1
  # DELETE /jewelries/1.json
  def destroy
    @jewelry = Jewelry.destroy(params[:id])

    respond_with @jewelry
  end
end
