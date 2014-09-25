class TodosSerializer < ActiveModel::ArraySerializer
  include Rails.application.routes.url_helpers

  delegate :default_url_options, :to => "ActionController::Base"

  def as_json(*args)
    hash = super
    hash[:_embedded] = { :todos => hash.delete("todos") }
    hash[:_links] = {
      "curies" => [{
        "name" => "todos",
        "href" => "http://todos.smartlogic.io/relations/{rel}",
        "templated" => true
      }],
      "self" => {
        "href" => todos_url,
      },
    }
    hash
  end
end
