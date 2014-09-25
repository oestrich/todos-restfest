class TodosController < ApplicationController
  def index
    render :json => Todo.all, :serializer => TodosSerializer, :each_serializer => TodoSerializer
  end
end
