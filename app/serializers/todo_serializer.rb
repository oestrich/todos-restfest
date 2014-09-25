class TodoSerializer < ActiveModel::Serializer
  include ApplicationSerializer

  attributes :id, :title, :due_date, :notes, :created_at, :updated_at, :completed_on

  def _links
    hash = super

    hash["self"] = {
      "href" => todo_url(id)
    }

    if todo.completed?
      hash["todos:incomplete"] = {
        "href" => incomplete_todo_url(todo)
      }
    else
      hash["todos:complete"] = {
        "href" => complete_todo_url(todo)
      }
    end

    hash
  end

  private

  def todo
    @object
  end
end
