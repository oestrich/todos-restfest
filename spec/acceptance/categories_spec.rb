require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Categories" do
  include_context :routes
  include_context :json

  let!(:category) do
    Category.create(:name => "Work")
  end

  get "/categories" do
    example_request "Viewing all categories" do
      expect(response_body).to be_json_eql({
        "_embedded" => {
          "categories" => [
            {
              "name" => "Work",
              "_links" => {
                "curies" => [{
                  "name" => "todos",
                  "href" => "http://todos.smartlogic.io/relations/{rel}",
                  "templated" => true
                }],
                "self" => {
                  "href" => category_url(category, :host => host),
                },
              },
            }
          ]
        },
        "_links" => {
          "curies" => [{
            "name" => "todos",
            "href" => "http://todos.smartlogic.io/relations/{rel}",
            "templated" => true
          }],
          "self" => {
            "href" => categories_url(:host => host),
            "name" => "Categories",
          },
          "up" => {
            "href" => root_url(:host => host),
          },
        },
      }.to_json)
    end
  end

  get "/categories/:id" do
    let(:id) { category.id }

    example_request "Viewing a category" do
      expect(response_body).to be_json_eql({
        "name" => "Work",
        "_links" => {
          "curies" => [{
            "name" => "todos",
            "href" => "http://todos.smartlogic.io/relations/{rel}",
            "templated" => true
          }],
          "self" => {
            "href" => category_url(category, :host => host),
          },
        },
      }.to_json)
    end
  end

  post "/categories" do
    parameter :name, "Name of the category", :required => true, :scope => "category", "Type" => "string"

    let(:name) { "School" }

    let(:raw_post) { params.to_json }

    example_request "Create a new category" do
      location = response_headers["Location"]
      expect(response_body).to be_json_eql({
        "name" => "School",
        "_links" => {
          "curies" => [{
            "name" => "todos",
            "href" => "http://todos.smartlogic.io/relations/{rel}",
            "templated" => true
          }],
          "self" => {
            "href" => location,
          },
        },
      }.to_json)
    end
  end
end
