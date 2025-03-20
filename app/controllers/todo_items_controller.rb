class TodoItemsController < ApplicationController
  before_action :set_todo_item, only: [:show, :edit, :update, :destroy]

  def index
    @todo_items = Current.user.todo_items
  end

  def show
  end

  def new
    @todo_item = Current.user.todo_items.new
    @todo_item.is_section = false
  end

  def new_section
    @todo_item = Current.user.todo_items.new
    @todo_item.is_section = true
    render :new
  end

  def edit
  end

  def create
    @todo_item = Current.user.todo_items.new(todo_item_params)

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
    redirect_to dashboard_path, notice: "Todo item was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions
    def set_todo_item
      @todo_item = Current.user.todo_items.find(params[:id])
    end

    # Only allow a list of trusted parameters through
    def todo_item_params
      params.require(:todo_item).permit(:name, :notes, :completed, :order, :is_section)
    end
end
