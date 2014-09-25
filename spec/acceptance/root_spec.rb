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
        }
      }.to_json)
    end
  end
end
