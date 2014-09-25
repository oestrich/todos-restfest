class RootController < ApplicationController
  def index
    render :json => {}, :serializer => RootSerializer
  end
end
