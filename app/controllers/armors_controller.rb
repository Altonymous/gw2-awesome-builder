class ArmorsController < ApplicationController
  # GET /armors
  # GET /armors.json
  def index
    @armors = Armor.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @armors }
    end
  end

  # GET /armors/1
  # GET /armors/1.json
  def show
    @armor = Armor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @armor }
    end
  end

  # GET /armors/new
  # GET /armors/new.json
  def new
    @armor = Armor.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @armor }
    end
  end

  # GET /armors/1/edit
  def edit
    @armor = Armor.find(params[:id])
  end

  # POST /armors
  # POST /armors.json
  def create
    @armor = Armor.new(params[:armor])

    respond_to do |format|
      if @armor.save
        format.html { redirect_to @armor, notice: 'Armor was successfully created.' }
        format.json { render json: @armor, status: :created, location: @armor }
      else
        format.html { render action: "new" }
        format.json { render json: @armor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /armors/1
  # PUT /armors/1.json
  def update
    @armor = Armor.find(params[:id])

    respond_to do |format|
      if @armor.update_attributes(params[:armor])
        format.html { redirect_to @armor, notice: 'Armor was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @armor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /armors/1
  # DELETE /armors/1.json
  def destroy
    @armor = Armor.find(params[:id])
    @armor.destroy

    respond_to do |format|
      format.html { redirect_to armors_url }
      format.json { head :no_content }
    end
  end
end
