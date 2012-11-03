class EnhancementsController < ApplicationController
  # GET /enhancements
  # GET /enhancements.json
  def index
    @enhancements = Enhancement.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @enhancements }
    end
  end

  # GET /enhancements/1
  # GET /enhancements/1.json
  def show
    @enhancement = Enhancement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @enhancement }
    end
  end

  # GET /enhancements/new
  # GET /enhancements/new.json
  def new
    @enhancement = Enhancement.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @enhancement }
    end
  end

  # GET /enhancements/1/edit
  def edit
    @enhancement = Enhancement.find(params[:id])
  end

  # POST /enhancements
  # POST /enhancements.json
  def create
    @enhancement = Enhancement.new(params[:enhancement])

    respond_to do |format|
      if @enhancement.save
        format.html { redirect_to @enhancement, notice: 'Enhancement was successfully created.' }
        format.json { render json: @enhancement, status: :created, location: @enhancement }
      else
        format.html { render action: "new" }
        format.json { render json: @enhancement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /enhancements/1
  # PUT /enhancements/1.json
  def update
    @enhancement = Enhancement.find(params[:id])

    respond_to do |format|
      if @enhancement.update_attributes(params[:enhancement])
        format.html { redirect_to @enhancement, notice: 'Enhancement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @enhancement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enhancements/1
  # DELETE /enhancements/1.json
  def destroy
    @enhancement = Enhancement.find(params[:id])
    @enhancement.destroy

    respond_to do |format|
      format.html { redirect_to enhancements_url }
      format.json { head :no_content }
    end
  end
end
