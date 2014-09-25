class CategorySerializer < ActiveModel::Serializer
  include ApplicationSerializer

  attributes :id, :name, :created_at, :updated_at, :_links

  def _links
    hash = super

    hash["self"] = {
      "href" => category_url(id)
    }

    hash
  end
end
