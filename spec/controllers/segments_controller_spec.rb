require 'rails_helper'

RSpec.describe SegmentsController, type: :controller do
  let(:valid_attributes) do
    {
      name: 'genre',
      label: 'Genre'
    }
  end

  let(:invalid_attributes) do
    {
      name: nil
    }
  end

  describe 'GET #index' do
    it 'assigns all segments as @segments' do
      segments = FactoryGirl.create_list(:segment, 2)
      get :index
      expect(assigns(:segments)).to eq segments
    end
  end

  describe 'GET #show' do
    it 'assigns the requested segment as @segment' do
      segment = FactoryGirl.create(:segment)
      get :show, id: segment.id
      expect(assigns(:segment)).to eq(segment)
    end
  end

  describe 'GET #new' do
    it 'assigns a new segment as @segment' do
      get :new
      expect(assigns(:segment)).to be_a_new(Segment)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested segment as @segment' do
      segment = Segment.create! valid_attributes
      get :edit, id: segment.id
      expect(assigns(:segment)).to eq(segment)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Segment' do
        expect do
          post :create, segment: valid_attributes
        end.to change(Segment, :count).by(1)
      end

      it 'assigns a newly created segment as @segment' do
        post :create, segment: valid_attributes
        expect(assigns(:segment)).to be_a(Segment)
        expect(assigns(:segment)).to be_persisted
      end

      it 'redirects to the created segment' do
        post :create, segment: valid_attributes
        expect(response).to redirect_to(Segment.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved segment as @segment' do
        post :create, segment: invalid_attributes
        expect(assigns(:segment)).to be_a_new(Segment)
      end

      it "re-renders the 'new' template" do
        post :create, segment: invalid_attributes
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        {
          label: 'New Label'
        }
      end

      it 'updates the requested segment' do
        segment = Segment.create! valid_attributes
        put :update, id: segment.id, segment: new_attributes
        segment.reload
        expect(segment.attributes).to include new_attributes.stringify_keys
      end

      it 'assigns the requested segment as @segment' do
        segment = Segment.create! valid_attributes
        put :update, id: segment.id, segment: valid_attributes
        expect(assigns(:segment)).to eq(segment)
      end

      it 'redirects to the segment' do
        segment = Segment.create! valid_attributes
        put :update, id: segment.id, segment: valid_attributes
        expect(response).to redirect_to(segment)
      end
    end

    context 'with invalid params' do
      it 'assigns the segment as @segment' do
        segment = Segment.create! valid_attributes
        put :update, id: segment.id, segment: invalid_attributes
        expect(assigns(:segment)).to eq(segment)
      end

      it "re-renders the 'edit' template" do
        segment = Segment.create! valid_attributes
        put :update, id: segment.id, segment: invalid_attributes
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested segment' do
      segment = Segment.create! valid_attributes
      expect do
        delete :destroy, id: segment.id
      end.to change(Segment, :count).by(-1)
    end

    it 'redirects to the segments list' do
      segment = Segment.create! valid_attributes
      delete :destroy, id: segment.id
      expect(response).to redirect_to(segments_url)
    end
  end
end
