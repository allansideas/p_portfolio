class CategoriesController < InheritedResources::Base
  def index
    @categories = Category.all
    if request.xhr?
      @category = Category.find(params[:category_id])
      render :partial => 'images_for_gallery', :layout => false
    else
      render :layout => 'application'
    end
  end
end
