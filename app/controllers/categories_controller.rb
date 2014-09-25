class CategoriesController < ApplicationController
  def index
    render({
      :json => Category.all,
      :serializer => CategoriesSerializer,
      :each_serializer => CategorySerializer,
    })
  end

  def show
    category = Category.find(params[:id])
    render :json => category, :serializer => CategorySerializer
  end

  def create
    category = Category.create(category_params)
    render({
      :json => category,
      :serializer => CategorySerializer,
      :status => 201,
      :location => category_url(category),
    })
  end

  def update
    category = Category.find(params[:id])
    category.update(category_params)
    render :json => category, :serializer => CategorySerializer
  end

  def destroy
    category = Category.find(params[:id])
    category.destroy
    render :nothing => true, :status => 204, :location => categories_url
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
