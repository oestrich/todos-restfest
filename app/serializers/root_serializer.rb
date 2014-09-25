class RootSerializer < ActiveModel::Serializer
  include ApplicationSerializer

  def _links
    base_links = super.merge({
      "self" => {
        "href" => root_url
      },
      "todos:incomplete" => {
        "href" => todos_url,
      },
      "todos:complete" => {
        "href" => completed_todos_url,
      },
    })
  end
end
