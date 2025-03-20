class TodoItem < ApplicationRecord
  belongs_to :user
  
  # Self-referential relationship for sections
  belongs_to :section, class_name: "TodoItem", optional: true
  has_many :todo_items, foreign_key: :section_id, class_name: "TodoItem", dependent: :nullify
  
  validates :name, presence: true
  validates :position, presence: true, numericality: { only_integer: true }
  
  default_scope { order(position: :asc) }
  
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
