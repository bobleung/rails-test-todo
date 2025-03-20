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
    ordered_ids = params[:todo_item][:ordered_ids]
  
    TodoItem.transaction do
      ordered_ids.each_with_index do |id, index|
        TodoItem.where(id: id).update_all(position: index + 1)
      end
    end
  
    head :ok
  end

  private
    def set_todo_item
      @todo_item = Current.user.todo_items.find(params[:id])
    end

    def todo_item_params
      params.require(:todo_item).permit(:name, :notes, :completed, :is_section, :section_id, :order)
    end
end
