require 'spec_helper'

describe UsersController do
  def valid_attributes
    {
      name: 'New User',
      email: 'new@example.com',
      password: 'please',
      password_confirmation: 'please'
    }
  end

  context 'as administrator' do
    let(:administrator) { create(:user, :administrator) }
    let(:user) { create(:user) }

    before(:each) do
      sign_in administrator
    end

    context 'GET "index"' do
      before(:each) do
        get :index
      end

      it { response.should be_success }
      it { assigns(:users).should eq([administrator, user]) }
    end

    context 'GET "show"' do
      it 'should be successful' do
        get :show, :id => user.to_param
        response.should be_success
      end

      it 'should find the right user' do
        get :show, :id => user.to_param
        assigns(:user).should == user
      end
    end

    context 'GET new' do
      it 'assigns a new user as @user' do
        get :new
        assigns(:user).should be_a_new(User)
      end
    end

    context 'GET edit' do
      it 'assigns the requested user as @user' do
        user = create(:user)
        get :edit, { id: user.to_param }
        assigns(:user).should eq(user)
      end
    end

    context 'POST "create"' do
      describe 'with valid params' do
        it 'creates a new User' do
          expect {
            post :create, { user: (valid_attributes) }
          }.to change(User, :count).by(1)
        end

        it 'assigns a newly created user as @user' do
          post :create, { user: (valid_attributes) }
          assigns(:user).should be_a(User)
          assigns(:user).should be_persisted
        end

        it 'redirects to the created user' do
          post :create, { user: (valid_attributes) }
          response.should redirect_to(User.last)
        end
      end

      describe 'with invalid params' do
        it 'assigns a newly created but unsaved user as @user' do
          User.any_instance.stub(:save).and_return(false)
          post :create, { user: {} }
          assigns(:user).should be_a_new(User)
        end

        it 'redirects to the "users#index" action' do
          User.any_instance.stub(:save).and_return(false)
          post :create, { user: {} }
          response.should redirect_to(controller: :users, action: :index)
        end
      end
    end

    context 'PUT "update"' do
      context 'with valid params' do
        it 'updates the requested user' do
          User.any_instance.should_receive(:update_attributes).with({ "name" => 'Test User Updated' })
          put :update, { id: user.to_param, user: { name: 'Test User Updated' } }
        end

        it 'assigns the requested user as @user' do
          put :update, { id: user.to_param }
          assigns(:user).should eq(user)
        end

        it 'redirects to the user' do
          put :update, { id: user.to_param }
          response.should redirect_to(user)
        end
      end

      context 'with invalid params' do
        it 'assigns the user as @user' do
          User.any_instance.stub(:save).and_return(false)
          put :update, {:id => user.to_param, :user => {}}
          assigns(:user).should eq(user)
        end

        it 'redirects to the "users#show" action' do
          User.any_instance.stub(:save).and_return(false)
          put :update, {:id => user.to_param, :user => {}}
          response.should redirect_to(controller: :users, action: :show)
        end
      end
    end

    context 'DELETE destroy' do
      it 'destroys the requested user' do
        user = create(:user)
        expect {
          delete :destroy, { id: user.to_param }
        }.to change(User, :count).by(-1)
      end

      it 'redirects to the users list' do
        delete :destroy, { id: user.to_param }
        response.should redirect_to(users_url)
      end
    end
  end

  context 'as user' do
    let(:administrator) { create(:user, :administrator) }
    let(:user) { create(:user) }

    before(:each) do
      sign_in user
    end

    context 'GET "index"' do
      it 'should be unsuccesful' do
        get :index, :id => user.to_param
        response.should_not be_success
      end
    end

    context 'GET "show"' do
      it 'should be successful' do
        get :show, :id => user.to_param
        response.should be_success
      end

      it 'should find the right user' do
        get :show, :id => user.to_param
        assigns(:user).should == user
      end

      it 'should be unsuccesful' do
        get :show, id: administrator.id
        response.should_not be_success
      end
    end

    context 'GET new' do
      it 'should be unsuccesful' do
        get :new
        response.should_not be_success
      end
    end

    context 'GET edit' do
      it 'assigns the requested user as @user' do
        get :edit, { id: user.to_param }
        assigns(:user).should eq(user)
      end

      it 'should be unsuccesful' do
        get :edit, { id: administrator.to_param }
        response.should_not be_success
      end
    end

    context 'POST "create"' do
      it 'should be unsuccesful' do
        get :create, { user: (valid_attributes) }
        response.should_not be_success
      end
    end

    context 'PUT "update"' do
      context 'with valid params' do
        it 'updates the requested user' do
          User.any_instance.should_receive(:update_with_password).with({ "name" => 'Test User Updated', "current_password" => 'please' })
          put :update, { id: user.to_param, user: { name: 'Test User Updated', current_password: 'please' } }
        end

        it 'assigns the requested user as @user' do
          put :update, { id: user.to_param, user: { name: 'Test User Updated', current_password: 'please' } }
          assigns(:user).should eq(user)
        end

        it 'redirects to the user' do
          put :update, { id: user.to_param, user: { name: 'Test User Updated', current_password: 'please' } }
          response.should redirect_to(user)
        end

        it 'should be unsuccesful' do
          put :update, { id: administrator.to_param, user: { name: 'Test User Updated', current_password: 'please' } }
          response.should_not be_success
        end
      end

      context 'with invalid params' do
        it 'raise MassAssignmentSecurity exception' do
          User.any_instance.stub(:save).and_return(false)
          expect {
            put :update, {:id => user.to_param, :user => { invalid: "param" }}
            }.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
        end
      end
    end

    context 'DELETE destroy' do
      it 'destroys the requested user' do
        expect {
          delete :destroy, { id: user.to_param }
        }.to change(User, :count).by(-1)
      end

      it 'redirects to the users list' do
        delete :destroy, { id: user.to_param }
        response.should redirect_to(users_url)
      end
    end
  end

  context 'as visitor' do
    context 'GET "index"' do
      it 'should be unsuccesful' do
        get :index, id: 1
        response.should_not be_success
      end
    end
  end
end
