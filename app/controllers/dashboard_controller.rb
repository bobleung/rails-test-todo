class DashboardController < ApplicationController
  def index
    @todo_items = Current.user.todo_items
  end
end