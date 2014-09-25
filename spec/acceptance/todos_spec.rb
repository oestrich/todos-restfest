require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Todos" do
  include_context :routes

  get "/todos" do
    let!(:todo) do
      Todo.create({
        :title => "finish my homework",
        :due_date => Date.parse("2014-10-01"),
        :notes => "calculus will be hard",
      })
    end

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
end
