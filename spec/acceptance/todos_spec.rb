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
    example_request "Viewing a list of all todos" do
      expect(response_body).to be_json_eql({
        "_embedded" => {
          "todos" => [
            {
              "title" => "finish my homework",
              "due_date" => "2014-10-01",
              "notes" => "calculus will be hard",
              "_links" => {
                "curies" => [{
                  "name" => "todos",
                  "href" => "http://todos.smartlogic.io/relations/{rel}",
                  "templated" => true
                }],
                "self" => {
                  "href" => todo_url(todo.id, :host => host),
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
        "_links" => {
          "curies" => [{
            "name" => "todos",
            "href" => "http://todos.smartlogic.io/relations/{rel}",
            "templated" => true
          }],
          "self" => {
            "href" => todo_url(todo.id, :host => host),
          },
        },
      }.to_json)
    end
  end

  post "/todos" do
    parameter :title, "Title of todo", "Type" => "string", :scope => "todo", :required => true
    parameter :due_date, "Date todo is due", "Type" => "date", :scope => "todo", :required => true
    parameter :notes, "Extra notes for the todo", "Type" => "string", :scope => "todo"

    let(:title) { "new title" }
    let(:due_date) { "2014-11-01" }

    example_request "Creating a new todo" do
      location = response_headers["Location"]
      expect(response_body).to be_json_eql({
        "title" => "new title",
        "due_date" => "2014-11-01",
        "notes" => nil,
        "_links" => {
          "curies" => [{
            "name" => "todos",
            "href" => "http://todos.smartlogic.io/relations/{rel}",
            "templated" => true
          }],
          "self" => {
            "href" => location,
          }
        },
      }.to_json).excluding("_links/self/href")
    end
  end
end
