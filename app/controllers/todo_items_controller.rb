class TodoItemsController < ApplicationController
  before_action :set_todo_item, only: [:show, :edit, :update, :destroy]

  def index
    @todo_items = Current.user.todo_items.order(:order)
  end

  def show
  end

  def new
    @todo_item = Current.user.todo_items.new
    @todo_item.is_section = false
  end

  def new_section
    @todo_item = Current.user.todo_items.new(is_section: true)
    render :new
  end

  def edit
  end

  def create
    @todo_item = Current.user.todo_items.new(todo_item_params)
    
    # Set initial order to be at the end of the list
    if @todo_item.order.nil?
      last_item = Current.user.todo_items.maximum(:order) || 0
      @todo_item.order = last_item + 1
    end

    if @todo_item.save
      redirect_to dashboard_path, notice: "Todo item was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @todo_item.update(todo_item_params)
      redirect_to dashboard_path, notice: "Todo item was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @todo_item.destroy
    redirect_to dashboard_path, notice: "Todo item was successfully deleted."
  end

  def reorder
    @todo_item = Current.user.todo_items.find(params[:todo_item][:id])
    
    # Update positions of all items based on ordered_ids
    if params[:todo_item][:ordered_ids].present?
      params[:todo_item][:ordered_ids].each_with_index do |id, index|
        Current.user.todo_items.find(id).update(order: index + 1)
      end
      
      head :ok
    else
      head :unprocessable_entity
    end
  end

  private
    def set_todo_item
      @todo_item = Current.user.todo_items.find(params[:id])
    end

    def todo_item_params
      params.require(:todo_item).permit(:name, :notes, :completed, :is_section, :section_id, :order)
    end
end
