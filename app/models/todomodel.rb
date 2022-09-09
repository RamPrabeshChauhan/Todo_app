class Todomodel
  include Mongoid::Document
  # include Mongoid::Timestamps

  field :tag, type: String
  field :title, type: String
  field :body, type: String
  field :status, type: String
end
