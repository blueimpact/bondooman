shared_examples_for FetchersController do
  let(:model_class) { controller.model_class }

  let(:model_sym) { model_class.model_name.singular.to_sym }

  describe 'GET #index' do
    it 'assigns all fetchers as @fetchers' do
      fetchers = [
        *FactoryGirl.create_list(:item_fetcher, 2).map(&:rebecome),
        *FactoryGirl.create_list(:ranking_fetcher, 2).map(&:rebecome)
      ].select { |f| f.is_a? model_class }
      get :index
      expect(assigns(:fetchers)).to eq fetchers
    end
  end

  describe 'GET #new' do
    it 'assigns a new fetcher as @fetcher' do
      get :new
      expect(assigns(:fetcher)).to be_a_new(model_class)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested fetcher as @fetcher' do
      fetcher = FactoryGirl.create(model_sym).rebecome
      get :show, { id: fetcher.id }
      expect(assigns(:fetcher)).to eq(fetcher)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested fetcher as @fetcher' do
      fetcher = FactoryGirl.create(model_sym)
      get :edit, { id: fetcher.id }
      expect(assigns(:fetcher)).to eq(fetcher)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Fetcher' do
        expect {
          post :create, { model_sym => valid_attributes }
        }.to change(Fetcher, :count).by(1)
      end

      it 'assigns a newly created fetcher as @fetcher' do
        post :create, { model_sym => valid_attributes }
        expect(assigns(:fetcher)).to be_a(Fetcher)
        expect(assigns(:fetcher)).to be_persisted
      end

      it 'redirects to the created fetcher' do
        post :create, { model_sym => valid_attributes }
        expect(response).to redirect_to(Fetcher.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved fetcher as @fetcher' do
        post :create, { model_sym => invalid_attributes }
        expect(assigns(:fetcher)).to be_a_new(Fetcher)
      end

      it "re-renders the 'new' template" do
        post :create, { model_sym => invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        {
          platform: Item::PLATFORMS.last,
          item_code: 'test.bondooman.new-item'
        }
      }

      it 'updates the requested fetcher' do
        fetcher = FactoryGirl.create(model_sym)
        put :update, { id: fetcher.id, model_sym => new_attributes }
        fetcher.reload
        expect(fetcher.platform).to eq Item::PLATFORMS.last
      end

      it 'assigns the requested fetcher as @fetcher' do
        fetcher = FactoryGirl.create(model_sym)
        put :update, { id: fetcher.id, model_sym => valid_attributes }
        expect(assigns(:fetcher)).to eq(fetcher)
      end

      it 'redirects to the fetcher' do
        fetcher = FactoryGirl.create(model_sym)
        put :update, { id: fetcher.id, model_sym => valid_attributes }
        expect(response).to redirect_to(fetcher)
      end
    end

    context 'with invalid params' do
      it 'assigns the fetcher as @fetcher' do
        fetcher = FactoryGirl.create(model_sym)
        put :update, { id: fetcher.id, model_sym => invalid_attributes }
        expect(assigns(:fetcher)).to eq(fetcher)
      end

      it "re-renders the 'edit' template" do
        fetcher = FactoryGirl.create(model_sym)
        put :update, { id: fetcher.id, model_sym => invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested fetcher' do
      fetcher = FactoryGirl.create(model_sym)
      expect {
        delete :destroy, { id: fetcher.id }
      }.to change(Fetcher, :count).by(-1)
    end

    it 'redirects to the fetchers list' do
      fetcher = FactoryGirl.create(model_sym)
      delete :destroy, { id: fetcher.id }
      expect(response).to redirect_to(fetchers_url)
    end
  end
end
