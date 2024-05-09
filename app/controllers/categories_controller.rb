class CategoriesController < ApplicationController

  def destroy
    @applicant = Applicant.find(params[:applicant_id])
    @category = @applicant.applicant_categories.where(category_id: params[:id]).first
    if @category.destroy
      redirect_to applicant_path(@applicant), notice: 'Category was successfully assigned'
    else
      redirect_to applicant_path(@applicant)
    end 
  end

  def create
    @applicant = Applicant.find(params[:applicant_id])
    @category = Category.find(category_params)
    if not @applicant.categories.include? @category
      @applicant.categories.append(@category)
      if @applicant.save
        redirect_to applicant_path(@applicant), notice: 'Category was successfully assigned'
      else
        redirect_to applicant_path(@applicant)
      end
    else
      redirect_to applicant_path(@applicant), error: 'Category already assigned'
    end
  end

  private
   def category_params
     params.require(:categories)
   end
end
