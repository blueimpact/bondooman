require 'rails_helper'

RSpec.describe FetchersController, type: :controller do
  login_admin

  let(:valid_attributes) {
    { platform: Item::PLATFORMS.first }
  }

  let(:invalid_attributes) {
    { platform: nil }
  }

  describe 'GET #index' do
    it 'assigns all fetchers as @fetchers' do
      fetcher = Fetcher.create! valid_attributes
      get :index
      expect(assigns(:fetchers)).to eq([fetcher])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested fetcher as @fetcher' do
      fetcher = Fetcher.create! valid_attributes
      get :show, { id: fetcher.id }
      expect(assigns(:fetcher)).to eq(fetcher)
    end
  end

  describe 'GET #new' do
    it 'assigns a new fetcher as @fetcher' do
      get :new
      expect(assigns(:fetcher)).to be_a_new(Fetcher)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested fetcher as @fetcher' do
      fetcher = Fetcher.create! valid_attributes
      get :edit, { id: fetcher.id }
      expect(assigns(:fetcher)).to eq(fetcher)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Fetcher' do
        expect {
          post :create, { fetcher: valid_attributes }
        }.to change(Fetcher, :count).by(1)
      end

      it 'assigns a newly created fetcher as @fetcher' do
        post :create, { fetcher: valid_attributes }
        expect(assigns(:fetcher)).to be_a(Fetcher)
        expect(assigns(:fetcher)).to be_persisted
      end

      it 'redirects to the created fetcher' do
        post :create, { fetcher: valid_attributes }
        expect(response).to redirect_to(Fetcher.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved fetcher as @fetcher' do
        post :create, { fetcher: invalid_attributes }
        expect(assigns(:fetcher)).to be_a_new(Fetcher)
      end

      it "re-renders the 'new' template" do
        post :create, { fetcher: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:genre) { FactoryGirl.create(:genre) }

      let(:segment) { FactoryGirl.create(:segment) }

      let(:new_attributes) {
        {
          platform: Item::PLATFORMS.last,
          genre_id: genre.id,
          segment_id: segment.id
        }
      }

      it 'updates the requested fetcher' do
        fetcher = Fetcher.create! valid_attributes
        put :update, { id: fetcher.id, fetcher: new_attributes }
        fetcher.reload
        expect(fetcher.platform).to eq Item::PLATFORMS.last
        expect(fetcher.genre_id).to eq genre.id
        expect(fetcher.segment_id).to eq segment.id
      end

      it 'assigns the requested fetcher as @fetcher' do
        fetcher = Fetcher.create! valid_attributes
        put :update, { id: fetcher.id, fetcher: valid_attributes }
        expect(assigns(:fetcher)).to eq(fetcher)
      end

      it 'redirects to the fetcher' do
        fetcher = Fetcher.create! valid_attributes
        put :update, { id: fetcher.id, fetcher: valid_attributes }
        expect(response).to redirect_to(fetcher)
      end
    end

    context 'with invalid params' do
      it 'assigns the fetcher as @fetcher' do
        fetcher = Fetcher.create! valid_attributes
        put :update, { id: fetcher.id, fetcher: invalid_attributes }
        expect(assigns(:fetcher)).to eq(fetcher)
      end

      it "re-renders the 'edit' template" do
        fetcher = Fetcher.create! valid_attributes
        put :update, { id: fetcher.id, fetcher: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested fetcher' do
      fetcher = Fetcher.create! valid_attributes
      expect {
        delete :destroy, { id: fetcher.id }
      }.to change(Fetcher, :count).by(-1)
    end

    it 'redirects to the fetchers list' do
      fetcher = Fetcher.create! valid_attributes
      delete :destroy, { id: fetcher.id }
      expect(response).to redirect_to(fetchers_url)
    end
  end
end
