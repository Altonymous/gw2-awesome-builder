class ArmorsController < ApplicationController
  # GET /armors
  # GET /armors.json
  def index
    @armors = Armor.all.page(params[:page])

    respond_with @armors
  end

  # GET /armors/1
  # GET /armors/1.json
  def show
    @armor = Armor.find(params[:id])

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
  end

  # POST /armors
  # POST /armors.json
  def create
    gear_enhancements = params[:armor].delete(:gear_enhancements)
    @armor = Armor.create(params[:armor]) do |armor|
      armor.gear_enhancements.build(gear_enhancements)
    end

    respond_with @armor
  end

  # PUT /armors/1
  # PUT /armors/1.json
  def update
    gear_enhancements = params[:armor].delete(:gear_enhancements)
    @armor = Armor.find(params[:id]) do |armor|
      armor.gear_enhancements.build(gear_enhancements)
    end

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
