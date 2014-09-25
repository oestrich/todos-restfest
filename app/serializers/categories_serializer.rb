class CategoriesSerializer < ActiveModel::ArraySerializer
  include Rails.application.routes.url_helpers

  delegate :default_url_options, :to => "ActionController::Base"

  def as_json(*args)
    hash = super
    hash[:_embedded] = { :categories => hash.delete("categories") }
    hash[:_links] = {
      "curies" => [{
        "name" => "todos",
        "href" => "http://todos.smartlogic.io/relations/{rel}",
        "templated" => true
      }],
      "self" => {
        "href" => categories_url,
        "name" => "Categories",
      },
      "up" => {
        "href" => root_url,
      }
    }

    hash
  end
end
