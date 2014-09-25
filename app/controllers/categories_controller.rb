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
end
