class TodosController < ApplicationController
  def index
    render({
      :json => Todo.incomplete.page(page).per(per_page),
      :serializer => TodosSerializer,
      :each_serializer => TodoSerializer,
      :page => page,
      :per_page => per_page,
    })
  end

  def completed
    render({
      :json => Todo.complete.page(page).per(per_page),
      :serializer => TodosSerializer,
      :each_serializer => TodoSerializer,
      :completed => true,
      :page => page,
      :per_page => per_page,
    })
  end

  def show
    todo = Todo.find(params[:id])
    render :json => todo, :serializer => TodoSerializer, :expanded_links => true
  end

  def create
    todo = Todo.create(todo_params)
    render :json => todo, :serializer => TodoSerializer, :status => 201, :location => todo_url(todo)
  end

  def update
    todo = Todo.where(:id => params[:id]).first

    if todo
      todo.update(todo_params)
      render :json => todo, :serializer => TodoSerializer
    else
      todo = Todo.create(todo_params.merge(:id => params[:id]))
      render :json => todo, :serializer => TodoSerializer, :status => 201
    end
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
    params.require(:todo).permit(:title, :due_date, :notes, :category_ids => [])
  end
end
