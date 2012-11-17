class SuitsController < ApplicationController
  include SortModule
  include ChildExtractionModule

  # GET /suits
  # GET /suits.json
  def index
    @sort ||= 'attack_power desc'
    @suits = Suit.order(@sort).page(params[:page])

    respond_with @suits
  end

  # GET /suits/1
  # GET /suits/1.json
  def show
    @suit = Suit.includes(:armors).find(params[:id])

    respond_with @suit
  end

  # GET /suits/new
  # GET /suits/new.json
  def new
    @suit = Suit.new

    respond_with @suit
  end

  # GET /suits/1/edit
  def edit
    @suit = Suit.find(params[:id])

    respond_with @suit
  end

  # POST /suits
  # POST /suits.json
  def create
    params_armors = params[:suit].delete(:armors)
    @suit = Suit.create(params[:suit]) do |suit|
      hydrate_children!(suit, params_armors, :armors, Armor)
    end

    respond_with @suit
  end

  # PUT /suits/1
  # PUT /suits/1.json
  def update
    @suit = Suit.find(params[:id])

    params_armors = params[:suit].delete(:armors)
    hydrate_children!(@suit, params_armors, :armors, Armor)

    @suit.update_attributes(params[:suit])

    respond_with @suit
  end

  # DELETE /suits/1
  # DELETE /suits/1.json
  def destroy
    @suit = Suit.destroy(params[:id])

    respond_with @suit
  end
end
