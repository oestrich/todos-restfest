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

    if todos.next_page
      hash[:_links]["next"] = {
        "href" => todos_url(:page => todos.next_page, :per_page => per_page)
      }
    end

    if todos.prev_page
      hash[:_links]["prev"] = {
        "href" => todos_url(:page => todos.prev_page, :per_page => per_page)
      }
    end

    unless todos.first_page?
      hash[:_links]["first"] = {
        "href" => todos_url(:page => 1, :per_page => per_page)
      }
    end

    if @options[:completed]
      hash[:_links]["self"] = {
        "href" => completed_todos_url(page_params),
        "name" => "Completed todos",
      }
    else
      hash[:_links]["self"] = {
        "href" => todos_url(page_params),
        "name" => "Incomplete todos",
      }
    end
    hash
  end

  private

  def todos
    @object
  end

  def page_params
    { :page => page, :per_page => per_page }
  end

  def page
    @options[:page]
  end

  def per_page
    @options[:per_page]
  end

  def todos_url(*args)
    if @options[:completed]
      completed_todos_url(*args)
    else
      super(*args)
    end
  end
end
