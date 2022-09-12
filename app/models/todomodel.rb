class Todomodel
  include Mongoid::Document
  # include Mongoid::Timestamps

  field :tag, type: String
  field :title, type: String
  field :body, type: String
  field :status, type: String
  field :visible, type: Boolean, default: true

  # it will show only one data
  paginates_per 2
end
