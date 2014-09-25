class TodoSerializer < ActiveModel::Serializer
  include ApplicationSerializer

  attributes :id, :title, :due_date, :notes, :created_at, :updated_at, :completed_on
  attributes :_embedded

  def as_json(*args)
    hash = super
    hash.delete(:categories)
    hash
  end

  def _embedded
    {
      "categories" => categories,
    }
  end

  def _links
    hash = super

    hash["self"] = {
      "href" => todo_url(id)
    }

    if @options[:expanded_links]
      hash["up"] = {
        "href" => todos_url,
      }
    end

    if todo.completed?
      hash["todos:incomplete"] = {
        "href" => incomplete_todo_url(todo),
        "name" => "Mark todo as incomplete",
      }
    else
      hash["todos:complete"] = {
        "href" => complete_todo_url(todo),
        "name" => "Mark todo as complete",
      }
    end

    hash
  end

  private

  def categories
    todo.categories.map do |todo|
      CategorySerializer.new(todo, @options)
    end
  end

  def todo
    @object
  end

  def todos_url(*args)
    if todo.completed?
      completed_todos_url(*args)
    else
      super(*args)
    end
  end
end
