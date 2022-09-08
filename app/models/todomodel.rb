class Todomodel
  include Mongoid::Document
  # include Mongoid::Timestamps

  field :tag, type: String
  field :body, type: String
end
