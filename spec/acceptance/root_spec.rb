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
            "templated" => true,
            "href" => "#{todos_url(:host => host)}{?page,per_page}",
            "name" => "Incomplete todos",
          },
          "todos:complete" => {
            "templated" => true,
            "href" => "#{completed_todos_url(:host => host)}{?page,per_page}",
            "name" => "Completed todos",
          },
          "todos:categories" => {
            "href" => categories_url(:host => host),
            "name" => "Categories",
          },
          "todos:docs" => {
            "href" => docs_url(:host => host),
            "name" => "Human documentation",
          },
          "todos:source" => {
            "href" => "https://github.com/oestrich/todos-restfest",
            "name" => "Link to github project",
          },
        }
      }.to_json)
    end
  end
end
