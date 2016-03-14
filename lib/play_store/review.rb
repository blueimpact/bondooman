module PlayStore
  class Review
    include ActiveModel::Model

    attr_accessor :title, :body, :rating, :created_at
    attr_accessor :index
  end
end
