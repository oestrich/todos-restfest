class RootSerializer < ActiveModel::Serializer
  include ApplicationSerializer

  def _links
    base_links = super.merge({
      "self" => {
        "href" => root_url
      },
      "todos:incomplete" => {
        "href" => todos_url,
        "name" => "Incomplete todos",
      },
      "todos:complete" => {
        "href" => completed_todos_url,
        "name" => "Completed todos",
      },
      "todos:docs" => {
        "href" => docs_url,
        "name" => "Human documentation",
      },
    })
  end
end
