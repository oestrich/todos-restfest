require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource "Root" do
  get "/" do
    example_request "Viewing the root resource" do
      expect(response_body).to be_json_eql({
      }.to_json)
    end
  end
end
