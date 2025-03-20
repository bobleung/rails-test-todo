class SectionsController < ApplicationController
  before_action :set_section, only: [:show, :edit, :update, :destroy]

  def index
    @sections = Current.user.todo_items.where(is_section: true).order(:order)
  end

  def show
  end

  def new
    @section = Current.user.todo_items.new(is_section: true)
  end

  def edit
  end

  def create
    @section = Current.user.todo_items.new(section_params.merge(is_section: true))
    
    # Set initial order to be at the end of the list
    if @section.order.nil?
      last_section = Current.user.todo_items.where(is_section: true).maximum(:order) || 0
      @section.order = last_section + 1
    end

    if @section.save
      redirect_to dashboard_path, notice: "Section was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @section.update(section_params)
      redirect_to dashboard_path, notice: "Section was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    # Before destroying the section, we need to handle its todo items
    # We'll make them standalone items without a section
    Current.user.todo_items.where(section_id: @section.id).update_all(section_id: nil)
    
    @section.destroy
    redirect_to dashboard_path, notice: "Section was successfully deleted."
  end

  def reorder
    @section = Current.user.todo_items.where(is_section: true).find(params[:section][:id])
    
    # Update positions of all sections based on ordered_ids
    if params[:section][:ordered_ids].present?
      params[:section][:ordered_ids].each_with_index do |id, index|
        Current.user.todo_items.where(is_section: true).find(id).update(order: index + 1)
      end
      
      head :ok
    else
      head :unprocessable_entity
    end
  end

  private
    def set_section
      @section = Current.user.todo_items.where(is_section: true).find(params[:id])
    end

    def section_params
      params.require(:todo_item).permit(:name, :order)
    end
end
