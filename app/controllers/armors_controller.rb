class ArmorsController < ApplicationController
  include SortModule
  include ChildExtractionModule

  # GET /armors
  # GET /armors.json
  def index
    @sort ||= 'attack_power desc'
    @armors = Armor.order(@sort).page(params[:page])

    respond_with @armors
  end

  # GET /armors/1
  # GET /armors/1.json
  def show
    @armor = Armor.includes(:gear_enhancements, :enhancements, :weight, :slot).find(params[:id])

    respond_with @armor
  end

  # GET /armors/new
  # GET /armors/new.json
  def new
    @armor = Armor.new

    respond_with @armor
  end

  # GET /armors/1/edit
  def edit
    @armor = Armor.find(params[:id])

    respond_with @armor
  end

  # POST /armors
  # POST /armors.json
  def create
    params_gear_enhancements = params[:armor].delete(:gear_enhancements)
    @armor = Armor.create(params[:armor]) do |armor|
      hydrate_child_relationship!(armor, params_gear_enhancements, :gear_enhancements)
    end

    respond_with @armor
  end

  # PUT /armors/1
  # PUT /armors/1.json
  def update
    @armor = Armor.find(params[:id])

    params_gear_enhancements = params[:armor].delete(:gear_enhancements)
    hydrate_child_relationship!(@armor, params_gear_enhancements, :gear_enhancements)

    @armor.update_attributes(params[:armor])

    respond_with @armor
  end

  # DELETE /armors/1
  # DELETE /armors/1.json
  def destroy
    @armor = Armor.destroy(params[:id])

    respond_with @armor
  end
end
