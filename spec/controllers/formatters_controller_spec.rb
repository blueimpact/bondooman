require 'rails_helper'

RSpec.describe FormattersController, type: :controller do
  login_admin

  let(:valid_attributes) {
    { item_body: 'Item Body' }
  }

  let(:invalid_attributes) {
    { item_body: nil }
  }

  describe 'GET #index' do
    it 'assigns all formatters as @formatters' do
      formatter = Formatter.create! valid_attributes
      get :index
      expect(assigns(:formatters)).to eq([formatter])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested formatter as @formatter' do
      formatter = Formatter.create! valid_attributes
      get :show, { id: formatter.id }
      expect(assigns(:formatter)).to eq(formatter)
    end
  end

  describe 'GET #new' do
    it 'assigns a new formatter as @formatter' do
      get :new
      expect(assigns(:formatter)).to be_a_new(Formatter)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested formatter as @formatter' do
      formatter = Formatter.create! valid_attributes
      get :edit, { id: formatter.id }
      expect(assigns(:formatter)).to eq(formatter)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Formatter' do
        expect {
          post :create, { formatter: valid_attributes }
        }.to change(Formatter, :count).by(1)
      end

      it 'assigns a newly created formatter as @formatter' do
        post :create, { formatter: valid_attributes }
        expect(assigns(:formatter)).to be_a(Formatter)
        expect(assigns(:formatter)).to be_persisted
      end

      it 'redirects to the created formatter' do
        post :create, { formatter: valid_attributes }
        expect(response).to redirect_to(Formatter.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved formatter as @formatter' do
        post :create, { formatter: invalid_attributes }
        expect(assigns(:formatter)).to be_a_new(Formatter)
      end

      it "re-renders the 'new' template" do
        post :create, { formatter: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) {
        { item_body: 'New Item Body' }
      }

      it 'updates the requested formatter' do
        formatter = Formatter.create! valid_attributes
        put :update, { id: formatter.id, formatter: new_attributes }
        formatter.reload
        expect(formatter.item_body).to eq 'New Item Body'
      end

      it 'assigns the requested formatter as @formatter' do
        formatter = Formatter.create! valid_attributes
        put :update, { id: formatter.id, formatter: valid_attributes }
        expect(assigns(:formatter)).to eq(formatter)
      end

      it 'redirects to the formatter' do
        formatter = Formatter.create! valid_attributes
        put :update, { id: formatter.id, formatter: valid_attributes }
        expect(response).to redirect_to(formatter)
      end
    end

    context 'with invalid params' do
      it 'assigns the formatter as @formatter' do
        formatter = Formatter.create! valid_attributes
        put :update, { id: formatter.id, formatter: invalid_attributes }
        expect(assigns(:formatter)).to eq(formatter)
      end

      it "re-renders the 'edit' template" do
        formatter = Formatter.create! valid_attributes
        put :update, { id: formatter.id, formatter: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested formatter' do
      formatter = Formatter.create! valid_attributes
      expect {
        delete :destroy, { id: formatter.id }
      }.to change(Formatter, :count).by(-1)
    end

    it 'redirects to the formatters list' do
      formatter = Formatter.create! valid_attributes
      delete :destroy, { id: formatter.id }
      expect(response).to redirect_to(formatters_url)
    end
  end
end
