class CategoriesController < InheritedResources::Base
  def index
    @categories = Category.all
  end

  def show
    @categories = Category.all
    @category = Category.find(params[:id])
  end 
end
