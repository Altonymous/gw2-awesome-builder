require 'spec_helper'

describe OutfitsController do
  let(:attack_power) { Enhancement.find_by_name('Power') }
  let(:helm) { create(:armor, :helm, :with_enhancement, enhancement: attack_power) }
  let(:shoulders) { create(:armor, :shoulders, :with_enhancement, enhancement: attack_power) }
  let(:coat) { create(:armor, :coat, :with_enhancement, enhancement: attack_power) }
  let(:gloves) { create(:armor, :gloves, :with_enhancement, enhancement: attack_power) }
  let(:legs) { create(:armor, :legs, :with_enhancement, enhancement: attack_power) }
  let(:boots) { create(:armor, :boots, :with_enhancement, enhancement: attack_power) }

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

  describe 'GET index' do
    it 'assigns all outfits as @outfits' do
      outfit = create(:outfit)
      get :index
      assigns(:outfits).should eq([outfit])
    end

    context 'sorting' do
      let(:outfits) { [] }

      before(:each) do
        outfits << create(:outfit)
        outfits << create(:outfit, helm: create(:armor, :helm, :with_enhancement, enhancement: Enhancement.find_by_name('Precision')))
      end

      context 'default' do
        it 'has the highest attack power at the top' do
          get :index
          assigns(:outfits).should eq(outfits)
        end

        it 'does not have the highest attack power at the bottom' do
          get :index
          assigns(:outfits).should_not eq(outfits.reverse!)
        end
      end

      context 'works on other enhancements' do
        it 'has the highest critical damage at the top' do
          get :index, { sort: 'critical_damage.desc' }
          assigns(:outfits).should eq(outfits)
        end

        it 'does not have the highest crtical damage at the bottom' do
          get :index, { sort: 'critical_damage.asc' }
          assigns(:outfits).should eq(outfits.reverse!)
        end
      end
    end
  end

  describe 'GET show' do
    it 'assigns the requested outfit as @outfit' do
      outfit = create(:outfit)
      get :show, { id: outfit.to_param }
      assigns(:outfit).should eq(outfit)
    end
  end

  describe 'GET new' do
    it 'assigns a new outfit as @outfit' do
      get :new
      assigns(:outfit).should be_a_new(Outfit)
    end
  end

  describe 'GET edit' do
    it 'assigns the requested outfit as @outfit' do
      outfit = create(:outfit)
      get :edit, { id: outfit.to_param }
      assigns(:outfit).should eq(outfit)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new Outfit' do
        expect {
          post :create, { outfit: (valid_attributes) }
        }.to change(Outfit, :count).by(1)
      end

      it 'assigns a newly created outfit as @outfit' do
        post :create, { outfit: (valid_attributes) }
        assigns(:outfit).should be_a(Outfit)
        assigns(:outfit).should be_persisted
      end

      it 'redirects to the created outfit' do
        post :create, { outfit: (valid_attributes) }
        response.should redirect_to(Outfit.last)
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved outfit as @outfit' do
        Outfit.any_instance.stub(:save).and_return(false)
        post :create, { outfit: {} }
        assigns(:outfit).should be_a_new(Outfit)
      end

      it 'redirects to the "outfits#index" action' do
        Outfit.any_instance.stub(:save).and_return(false)
        post :create, { outfit: {} }
        response.should redirect_to(controller: :outfits, action: :index)
      end
    end
  end

  describe 'PUT update' do
    describe 'with valid params' do
      it 'updates the requested outfit' do
        outfit = create(:outfit)
        Outfit.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {id: outfit.to_param, outfit: {'these' => 'params'}}
      end

      it 'assigns the requested outfit as @outfit' do
        outfit = create(:outfit)
        put :update, {:id => outfit.to_param, :outfit =>(valid_attributes)}
        assigns(:outfit).should eq(outfit)
      end

      it 'redirects to the outfit' do
        outfit = create(:outfit)
        put :update, {:id => outfit.to_param, :outfit =>(valid_attributes)}
        response.should redirect_to(outfit)
      end
    end

    describe 'with invalid params' do
      it 'assigns the outfit as @outfit' do
        outfit = create(:outfit)
        Outfit.any_instance.stub(:save).and_return(false)
        put :update, {:id => outfit.to_param, :outfit => {}}
        assigns(:outfit).should eq(outfit)
      end

      it 'redirects to the "outfits#show" action' do
        outfit = create(:outfit)
        Outfit.any_instance.stub(:save).and_return(false)
        put :update, {:id => outfit.to_param, :outfit => {}}
        response.should redirect_to(controller: :outfits, action: :show)
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroys the requested outfit' do
      outfit = create(:outfit)
      expect {
        delete :destroy, {:id => outfit.to_param}
      }.to change(Outfit, :count).by(-1)
    end

    it 'redirects to the outfits list' do
      outfit = create(:outfit)
      delete :destroy, {:id => outfit.to_param}
      response.should redirect_to(outfits_url)
    end
  end

end
