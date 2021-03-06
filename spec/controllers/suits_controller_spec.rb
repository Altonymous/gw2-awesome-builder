require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe SuitsController do
  let(:attack_power_enhancement) { Enhancement.find_by_name('Power') }
  let(:helm) { create(:armor, :helm, enhancement: attack_power_enhancement) }
  let(:shoulders) { create(:armor, :shoulders, enhancement: attack_power_enhancement) }
  let(:coat) { create(:armor, :coat, enhancement: attack_power_enhancement) }
  let(:gloves) { create(:armor, :gloves, enhancement: attack_power_enhancement) }
  let(:legs) { create(:armor, :legs, enhancement: attack_power_enhancement) }
  let(:boots) { create(:armor, :boots, enhancement: attack_power_enhancement) }

  # This should return the minimal set of attributes required to create a valid
  # Suit. As you add validations to Suit, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {
      armors: [
        { id: helm.id },
        { id: shoulders.id },
        { id: coat.id },
        { id: gloves.id },
        { id: legs.id },
        { id: boots.id }
      ]
    }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SuitsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all suits as @suits" do
      suit = create(:suit)
      get :index, {}, valid_session
      assigns(:suits).should eq([suit])
    end
  end

  describe "GET show" do
    it "assigns the requested suit as @suit" do
      suit = create(:suit)
      get :show, {:id => suit.to_param}, valid_session
      assigns(:suit).should eq(suit)
    end
  end

  describe "GET new" do
    it "assigns a new suit as @suit" do
      get :new, {}, valid_session
      assigns(:suit).should be_a_new(Suit)
    end
  end

  describe "GET edit" do
    it "assigns the requested suit as @suit" do
      suit = create(:suit)
      get :edit, {:id => suit.to_param}, valid_session
      assigns(:suit).should eq(suit)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Suit" do
        expect {
          post :create, {:suit => valid_attributes}, valid_session
        }.to change(Suit, :count).by(1)
      end

      it "assigns a newly created suit as @suit" do
        post :create, {:suit => valid_attributes}, valid_session
        assigns(:suit).should be_a(Suit)
        assigns(:suit).should be_persisted
      end

      it "redirects to the created suit" do
        post :create, {:suit => valid_attributes}, valid_session
        response.should redirect_to(Suit.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved suit as @suit" do
        # Trigger the behavior that occurs when invalid params are submitted
        Suit.any_instance.stub(:save).and_return(false)
        post :create, {:suit => {}}, valid_session
        assigns(:suit).should be_a_new(Suit)
      end

      it "redirects to the 'suits#index' action" do
        # Trigger the behavior that occurs when invalid params are submitted
        Suit.any_instance.stub(:save).and_return(false)
        post :create, {:suit => {}}, valid_session
        response.should redirect_to(controller: :suits, action: :index)
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested suit" do
        suit = create(:suit)
        # Assuming there are no other suits in the database, this
        # specifies that the Suit created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Suit.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => suit.to_param, :suit => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested suit as @suit" do
        suit = create(:suit)
        put :update, {:id => suit.to_param, :suit => valid_attributes}, valid_session
        assigns(:suit).should eq(suit)
      end

      it "redirects to the suit" do
        suit = create(:suit)
        put :update, {:id => suit.to_param, :suit => valid_attributes}, valid_session
        response.should redirect_to(suit)
      end
    end

    describe "with invalid params" do
      it "assigns the suit as @suit" do
        suit = create(:suit)
        # Trigger the behavior that occurs when invalid params are submitted
        Suit.any_instance.stub(:save).and_return(false)
        put :update, {:id => suit.to_param, :suit => {}}, valid_session
        assigns(:suit).should eq(suit)
      end

      it "redirects to the 'suits#show' action" do
        suit = create(:suit)
        # Trigger the behavior that occurs when invalid params are submitted
        Suit.any_instance.stub(:save).and_return(false)
        put :update, {:id => suit.to_param, :suit => {}}, valid_session
        response.should redirect_to(controller: :suits, action: :show)
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested suit" do
      suit = create(:suit)
      expect {
        delete :destroy, {:id => suit.to_param}, valid_session
      }.to change(Suit, :count).by(-1)
    end

    it "redirects to the suits list" do
      suit = create(:suit)
      delete :destroy, {:id => suit.to_param}, valid_session
      response.should redirect_to(suits_url)
    end
  end

end
