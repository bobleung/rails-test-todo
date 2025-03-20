class TodoItem < ApplicationRecord
  belongs_to :user
  
  validates :name, presence: true
  validates :order, presence: true, numericality: { only_integer: true }
  
  default_scope { order(order: :asc) }
  
  # Scopes for filtering todo items
  scope :regular_items, -> { where(is_section: false) }
  scope :sections, -> { where(is_section: true) }
  
  # Sections can't be completed
  before_save :prevent_section_completion
  
  private
  
  def prevent_section_completion
    self.completed = false if is_section?
  end
end
