class TodoSerializer < ActiveModel::Serializer
  include ApplicationSerializer

  attributes :id, :title, :due_date, :notes, :created_at, :updated_at

  def _links
    hash = super

    hash["self"] = {
      "href" => todo_url(id)
    }

    hash
  end
end
