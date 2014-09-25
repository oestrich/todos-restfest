class TodosController < ApplicationController
  def index
    render :json => Todo.incomplete, :serializer => TodosSerializer, :each_serializer => TodoSerializer
  end

  def completed
    render :json => Todo.complete, :serializer => TodosSerializer, :each_serializer => TodoSerializer, :completed => true
  end

  def show
    todo = Todo.find(params[:id])
    render :json => todo, :serializer => TodoSerializer
  end

  def create
    todo = Todo.create(todo_params)
    render :json => todo, :serializer => TodoSerializer, :status => 201, :location => todo_url(todo)
  end

  def complete
    todo = Todo.find(params[:id])
    todo.complete!
    render :json => todo, :serializer => TodoSerializer
  end

  def incomplete
    todo = Todo.find(params[:id])
    todo.incomplete!
    render :json => todo, :serializer => TodoSerializer
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :due_date, :notes)
  end
end
