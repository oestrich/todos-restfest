class TodosController < ApplicationController
  def index
    render :json => Todo.all, :serializer => TodosSerializer, :each_serializer => TodoSerializer
  end

  def show
    todo = Todo.find(params[:id])
    render :json => todo, :serializer => TodoSerializer
  end

  def create
    todo = Todo.create(todo_params)
    render :json => todo, :serializer => TodoSerializer, :status => 201, :location => todo_url(todo)
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :due_date, :notes)
  end
end
