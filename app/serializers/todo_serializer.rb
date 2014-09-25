class TodoSerializer < ActiveModel::Serializer
  include ApplicationSerializer

  attributes :id, :title, :due_date, :notes, :created_at, :updated_at
end
