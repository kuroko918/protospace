require 'rails_helper'

describe PrototypesController do
   let!(:prototype) { create(:prototype, :prototype_with_main_image) }
   let!(:like) {
     create(:like, user: prototype.user, prototype: prototype)
   }
   let(:params) {{
     id: prototype,
     prototype: attributes_for(:prototype, title: 'hoge')
   }}
   let(:invalid_params) {{
     id: prototype,
     prototype: attributes_for(:prototype, title: nil)
   }}

  context 'with user login' do
    before { sign_in prototype.user }

    describe 'GET #new' do
      before { get :new }

      it 'assignes the requested prototype to @prototype' do
        expect(assigns(:prototype)).to be_a_new(Prototype)
      end

      it 'renders the :new template' do
        expect(response).to render_template :new
      end
    end

    describe 'POST #create' do
      context 'with valid attribtues' do
        before { post :create, params }

        it 'saves the new prototype in the database' do
          expect {
            post :create, params
          }.to change(Prototype, :count).by(1)
        end

        it 'redirects to root_path' do
          expect(response).to redirect_to root_path
        end

        it 'shows flash messages to show save the prototype successfully' do
          expect(flash[:notice]).to eq 'exactly saved'
        end
      end

      context 'with invalid attribtues' do
        before { post :create, invalid_params }

        it 'does not save the new prototype in the database' do
          expect {
            post :create, invalid_params
          }.not_to change(Prototype, :count)
        end

        it 'redirects new_prototype_path' do
          expect(response).to render_template :new
        end

        it 'shows flash messages to show save the prototype unsuccessfully' do
          expect(assigns(:prototype).errors.full_messages).to eq ["Title can't be blank"]
        end
      end
    end

    describe 'GET #show' do
      before { get :show, id: prototype }

      it 'assigns the requested prototype to @prototype' do
        expect(assigns(:prototype)).to eq prototype
      end

      it 'assigns the requested comment to @comment' do
        expect(assigns(:comment)).to be_a_new(Comment)
      end

      it 'assigns like associated with prototype to @like' do
        user = prototype.user
        expect(assigns(:like)).to eq prototype.likes.find_by(user_id: user.id)
      end

      it 'renders the :show template' do
        expect(response).to render_template :show
      end
    end

    describe 'GET #edit' do
      before { get :edit, id: prototype }

      it 'assigns the requested prototype to @prototype' do
        expect(assigns(:prototype)).to eq prototype
      end

      it 'assigns main_image to @main_image' do
        expect(assigns(:main_image)).to eq prototype.images.main[0]
      end

      it 'assigns sub_images to @sub_images' do
        expect(assigns(:sub_images)).to eq prototype.images.sub
      end

      it 'renders the :edit template' do
        expect(response).to render_template :edit
      end
    end

    describe 'PATCH #update' do
      context 'with valid attributes' do
        before { patch :update, params }

        it 'assigns the requested prototype to @prototype' do
          expect(assigns(:prototype)).to eq prototype
        end

        it 'updates attributes of prototype' do
          prototype.reload
          expect(prototype.title).to eq 'hoge'
        end

        it 'redirects to root_path'  do
          expect(response).to redirect_to root_path
        end

        it 'shows flash message to show update prototype successfully' do
          prototype.reload
          expect(flash[:notice]).to eq 'Updated Successfully'
        end
      end

      context 'with invalid attributes' do
        before { patch :update, invalid_params }

        it 'assigns the requested prototype to @prototype' do
          expect(assigns(:prototype)).to eq prototype
        end

        it 'does not save the new prototype' do
          prototype.reload
          expect(prototype.title).not_to eq 'hoge'
        end

        it 'renders the :edit template' do
          expect(response).to render_template :edit
        end

        it 'shows flash message to show update prototype unsuccessfully' do
          expect(assigns(:prototype).errors.full_messages).to eq ["Title can't be blank"]
        end
      end
    end

    describe 'DELETE #destroy' do

      it 'assigns the requested prototype to @prototype' do
        delete :destroy, id: prototype
        expect(assigns(:prototype)).to eq prototype
      end

     it 'deletes the prototype' do
      expect{
        delete :destroy, id: prototype
      }.to change(Prototype, :count).by(-1)
     end

     it 'redirects to root_path' do
      delete :destroy, id: prototype
      expect(response).to redirect_to root_path
     end

     it 'shows flash message to show delete prototype successfully' do
      delete :destroy, id: prototype
      expect(flash[:notice]).to eq 'Deleted Successfully'
     end
    end
  end

  context 'without user login' do
    describe 'GET #new' do
      it 'redirects sign_in page' do
        get :new
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'POST #create' do
      it 'redirects sign_in page' do
        post :create
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'GET #edit' do
      it 'redirects sign_in page' do
        get :edit, id: prototype
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'PATCH #update' do
      it 'redirects sign_in page' do
        patch :update, id: prototype
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'DELETE #destroy' do
      it 'redirects sign_in page' do
        delete :destroy, id: prototype
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
