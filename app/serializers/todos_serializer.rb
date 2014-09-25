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
      "up" => {
        "href" => root_url,
      }
    }

    if @options[:completed]
      hash[:_links]["self"] = {
        "href" => completed_todos_url,
      }
    else
      hash[:_links]["self"] = {
        "href" => todos_url,
      }
    end
    hash
  end
end
