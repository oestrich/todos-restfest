require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Todos" do
  include_context :routes
  include_context :json

  let!(:todo) do
    Todo.create({
      :title => "finish my homework",
      :due_date => Date.parse("2014-10-01"),
      :notes => "calculus will be hard",
    })
  end

  get "/todos" do
    let!(:completed_todo) do
      Todo.create({
        :title => "finish my homework again",
        :completed_on => Date.today,
      })
    end

    example_request "Viewing a list of all incomplete todos" do
      expect(response_body).to be_json_eql({
        "_embedded" => {
          "todos" => [
            {
              "title" => "finish my homework",
              "due_date" => "2014-10-01",
              "notes" => "calculus will be hard",
              "completed_on" => nil,
              "_links" => {
                "curies" => [{
                  "name" => "todos",
                  "href" => "http://todos.smartlogic.io/relations/{rel}",
                  "templated" => true
                }],
                "self" => {
                  "href" => todo_url(todo.id, :host => host),
                },
                "todos:complete" => {
                  "href" => complete_todo_url(todo.id, :host => host),
                },
              },
            },
          ],
        },
        "_links" => {
          "curies" => [{
            "name" => "todos",
            "href" => "http://todos.smartlogic.io/relations/{rel}",
            "templated" => true
          }],
          "self" => {
            "href" => todos_url(:host => host),
          },
          "up" => {
            "href" => root_url(:host => host),
          },
        }
      }.to_json)
    end
  end

  get "/todos/completed" do
    let!(:completed_todo) do
      Todo.create({
        :title => "finish my homework again",
        :completed_on => Date.today,
      })
    end

    example_request "Viewing a list of all completed todos" do
      expect(response_body).to be_json_eql({
        "_embedded" => {
          "todos" => [
            {
              "title" => "finish my homework again",
              "due_date" => nil,
              "notes" => nil,
              "completed_on" => Date.today,
              "_links" => {
                "curies" => [{
                  "name" => "todos",
                  "href" => "http://todos.smartlogic.io/relations/{rel}",
                  "templated" => true
                }],
                "self" => {
                  "href" => todo_url(completed_todo.id, :host => host),
                },
                "todos:incomplete" => {
                  "href" => incomplete_todo_url(completed_todo.id, :host => host),
                },
              },
            },
          ],
        },
        "_links" => {
          "curies" => [{
            "name" => "todos",
            "href" => "http://todos.smartlogic.io/relations/{rel}",
            "templated" => true
          }],
          "self" => {
            "href" => completed_todos_url(:host => host),
          },
          "up" => {
            "href" => root_url(:host => host),
          },
        }
      }.to_json)
    end
  end

  get "/todos/:id" do
    let(:id) do
      todo.id
    end

    example_request "Viewing a todo" do
      expect(response_body).to be_json_eql({
        "title" => "finish my homework",
        "due_date" => "2014-10-01",
        "notes" => "calculus will be hard",
        "completed_on" => nil,
        "_links" => {
          "curies" => [{
            "name" => "todos",
            "href" => "http://todos.smartlogic.io/relations/{rel}",
            "templated" => true
          }],
          "self" => {
            "href" => todo_url(todo.id, :host => host),
          },
          "todos:complete" => {
            "href" => complete_todo_url(todo.id, :host => host),
          },
        },
      }.to_json)
    end
  end

  post "/todos" do
    parameter :title, "Title of todo", "Type" => "string", :scope => "todo", :required => true
    parameter :due_date, "Date todo is due", "Type" => "date", :scope => "todo"
    parameter :notes, "Extra notes for the todo", "Type" => "string", :scope => "todo"

    let(:title) { "new title" }
    let(:due_date) { "2014-11-01" }

    example_request "Creating a new todo" do
      location = response_headers["Location"]
      todo_id = location.split("/").last
      expect(response_body).to be_json_eql({
        "title" => "new title",
        "due_date" => "2014-11-01",
        "notes" => nil,
        "completed_on" => nil,
        "_links" => {
          "curies" => [{
            "name" => "todos",
            "href" => "http://todos.smartlogic.io/relations/{rel}",
            "templated" => true
          }],
          "self" => {
            "href" => location,
          },
          "todos:complete" => {
            "href" => complete_todo_url(todo_id, :host => host),
          },
        },
      }.to_json).excluding("_links/self/href")
      expect(status).to eq(201)
    end
  end

  post "/todos/:id/complete" do
    let(:id) { todo.id }

    example_request "Completing a todo" do
      expect(response_body).to be_json_eql({
        "title" => "finish my homework",
        "due_date" => "2014-10-01",
        "notes" => "calculus will be hard",
        "completed_on" => Date.today,
        "_links" => {
          "curies" => [{
            "name" => "todos",
            "href" => "http://todos.smartlogic.io/relations/{rel}",
            "templated" => true
          }],
          "self" => {
            "href" => todo_url(todo.id, :host => host),
          },
          "todos:incomplete" => {
            "href" => incomplete_todo_url(todo.id, :host => host),
          },
        },
      }.to_json)
    end
  end

  post "/todos/:id/incomplete" do
    let(:id) { todo.id }

    example_request "Undoing a completed todo" do
      expect(response_body).to be_json_eql({
        "title" => "finish my homework",
        "due_date" => "2014-10-01",
        "notes" => "calculus will be hard",
        "completed_on" => nil,
        "_links" => {
          "curies" => [{
            "name" => "todos",
            "href" => "http://todos.smartlogic.io/relations/{rel}",
            "templated" => true
          }],
          "self" => {
            "href" => todo_url(todo.id, :host => host),
          },
          "todos:complete" => {
            "href" => complete_todo_url(todo.id, :host => host),
          },
        },
      }.to_json)
    end
  end
end
