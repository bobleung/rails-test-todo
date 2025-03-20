class SectionsController < ApplicationController
  before_action :set_section, only: [:show, :edit, :update, :destroy]

  def index
    @sections = Current.user.sections
  end

  def show
  end

  def new
    @section = Current.user.sections.new
  end

  def edit
  end

  def create
    @section = Current.user.sections.new(section_params)

    if @section.save
      redirect_to sections_path, notice: "Section was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @section.update(section_params)
      redirect_to sections_path, notice: "Section was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @section.destroy
    redirect_to sections_path, notice: "Section was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions
    def set_section
      @section = Current.user.sections.find(params[:id])
    end

    # Only allow a list of trusted parameters through
    def section_params
      params.require(:section).permit(:name, :order)
    end
end
