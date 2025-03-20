class DashboardController < ApplicationController
  def index
    # Get sections (todo items with is_section=true)
    @sections = Current.user.todo_items.where(is_section: true).order(:order)
    
    # Get standalone todo items (those not in any section)
    @standalone_todo_items = Current.user.todo_items.where(is_section: false, section_id: nil).order(:order)
  end
end