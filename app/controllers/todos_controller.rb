class TodosController < ApplicationController
  def index
    render :json => Todo.all, :serializer => TodosSerializer, :each_serializer => TodoSerializer
  end

  def show
    todo = Todo.find(params[:id])
    render :json => todo, :serializer => TodoSerializer
  end
end
