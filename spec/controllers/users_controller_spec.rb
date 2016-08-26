require 'rails_helper'

describe UsersController do
  let!(:user) { create(:user) }
  let(:params) {{
    id: user,
    user: attributes_for(:user, name: 'hoge')
  }}
  let(:invalid_params) {{
    id: user,
    user: attributes_for(:user, name: nil)
  }}

  context 'with user login' do
    before { sign_in user }

    describe 'GET #show' do
      it "assigns the requested to @user" do
        get :show, id: user
        expect(assigns(:user)).to eq user
      end

      it "renders the :show templates" do
        get :show, id: user
        expect(response).to render_template :show
      end
    end

    describe 'GET #edit' do
      it "assigns the requested user to @user" do
        get :edit, id: user
        expect(assigns(:user)).to eq user
      end

      it "renders the :edit template" do
        get :edit, id: user
        expect(response).to render_template :edit
      end
    end

    describe 'PATCH #update' do
      context 'with valid attributes' do
        it "assigns the requested user to @user" do
          patch :update, params
          expect(assigns(:user)).to eq user
        end

        it "changes @user's attributes" do
          patch :update, params
          user.reload
          expect(user.name).to eq "hoge"
        end

        it "redirects to root path" do
          patch :update, params
          expect(response).to redirect_to root_path
        end

        it "sends flash messages" do
          patch :update, params
          expect(response).to redirect_to root_path
          expect(flash[:notice]).to eq 'Profile updated successfully'
        end
      end

      context 'with invalid attributes' do
        it "assigns the requested user to @user" do
          patch :update, invalid_params
          expect(assigns(:user)).to eq user
        end

        it "does not save the new user" do
          patch :update, invalid_params
          user.reload
          expect(user.name).not_to eq "hoge"
        end

        it "render_template :edit" do
          patch :update, invalid_params
          expect(response).to render_template :edit
        end

        it 'shows error messages' do
          patch :update, invalid_params
          user.reload
          expect(assigns(:user).errors.full_messages).to eq ["Name can't be blank"]
        end
      end
    end
  end

  context 'without user login' do
    describe 'GET #edit' do
      it "redirects sign_in page" do
        get :edit, id: user
        expect(response).to redirect_to new_user_session_path
      end
    end
    describe 'PATCH #update' do
      it "redirects sign_in page" do
        patch :update, params
        user.reload
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
