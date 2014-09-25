require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Root" do
  include_context :routes

  get "/" do
    example_request "Viewing the root resource" do
      expect(response_body).to be_json_eql({
        "_links" => {
          "curies" => [{
            "name" => "todos",
            "href" => "http://todos.smartlogic.io/relations/{rel}",
            "templated" => true
          }],
          "self" => {
            "href" => root_url(:host => host),
          },
          "todos:incomplete" => {
            "href" => todos_url(:host => host),
            "name" => "Incomplete todos",
          },
          "todos:complete" => {
            "href" => completed_todos_url(:host => host),
            "name" => "Completed todos",
          },
        }
      }.to_json)
    end
  end
end
