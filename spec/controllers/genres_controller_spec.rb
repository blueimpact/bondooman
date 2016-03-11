require 'rails_helper'

RSpec.describe GenresController, type: :controller do
  let(:valid_attributes) {
    {
      name: 'genre',
      label: 'Genre'
    }
  }

  let(:invalid_attributes) {
    {
      name: nil
    }
  }

  describe "GET #index" do
    it "assigns all genres as @genres" do
      genres = FactoryGirl.create_list(:genre, 2)
      get :index
      expect(assigns(:genres)).to eq genres
    end
  end

  describe "GET #show" do
    it "assigns the requested genre as @genre" do
      genre = FactoryGirl.create(:genre)
      get :show, {id: genre.id}
      expect(assigns(:genre)).to eq(genre)
    end
  end

  describe "GET #new" do
    it "assigns a new genre as @genre" do
      get :new, {}
      expect(assigns(:genre)).to be_a_new(Genre)
    end
  end

  describe "GET #edit" do
    it "assigns the requested genre as @genre" do
      genre = Genre.create! valid_attributes
      get :edit, {id: genre.id}
      expect(assigns(:genre)).to eq(genre)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Genre" do
        expect {
          post :create, {:genre => valid_attributes}
        }.to change(Genre, :count).by(1)
      end

      it "assigns a newly created genre as @genre" do
        post :create, {:genre => valid_attributes}
        expect(assigns(:genre)).to be_a(Genre)
        expect(assigns(:genre)).to be_persisted
      end

      it "redirects to the created genre" do
        post :create, {:genre => valid_attributes}
        expect(response).to redirect_to(Genre.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved genre as @genre" do
        post :create, {:genre => invalid_attributes}
        expect(assigns(:genre)).to be_a_new(Genre)
      end

      it "re-renders the 'new' template" do
        post :create, {:genre => invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          label: 'New Label'
        }
      }

      it "updates the requested genre" do
        genre = Genre.create! valid_attributes
        put :update, {id: genre.id, :genre => new_attributes}
        genre.reload
        expect(genre.attributes).to include new_attributes.stringify_keys
      end

      it "assigns the requested genre as @genre" do
        genre = Genre.create! valid_attributes
        put :update, {id: genre.id, :genre => valid_attributes}
        expect(assigns(:genre)).to eq(genre)
      end

      it "redirects to the genre" do
        genre = Genre.create! valid_attributes
        put :update, {id: genre.id, :genre => valid_attributes}
        expect(response).to redirect_to(genre)
      end
    end

    context "with invalid params" do
      it "assigns the genre as @genre" do
        genre = Genre.create! valid_attributes
        put :update, {id: genre.id, :genre => invalid_attributes}
        expect(assigns(:genre)).to eq(genre)
      end

      it "re-renders the 'edit' template" do
        genre = Genre.create! valid_attributes
        put :update, {id: genre.id, :genre => invalid_attributes}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested genre" do
      genre = Genre.create! valid_attributes
      expect {
        delete :destroy, {id: genre.id}
      }.to change(Genre, :count).by(-1)
    end

    it "redirects to the genres list" do
      genre = Genre.create! valid_attributes
      delete :destroy, {id: genre.id}
      expect(response).to redirect_to(genres_url)
    end
  end

end
