class RootSerializer < ActiveModel::Serializer
  include ApplicationSerializer

  def _links
    base_links = super.merge({
      "self" => {
        "href" => root_url
      },
      "todos:incomplete" => {
        "templated" => true,
        "href" => "#{todos_url}{?page,per_page}",
        "name" => "Incomplete todos",
      },
      "todos:complete" => {
        "templated" => true,
        "href" => "#{completed_todos_url}{?page,per_page}",
        "name" => "Completed todos",
      },
      "todos:categories" => {
        "href" => categories_url,
        "name" => "Categories",
      },
      "todos:docs" => {
        "href" => docs_url,
        "name" => "Human documentation",
      },
      "todos:source" => {
        "href" => "https://github.com/oestrich/todos-restfest",
        "name" => "Link to github project",
      },
    })
  end
end
