# Specification for the Todo list

## Data Model
- Each user can only see their own todo items
- User can create, edit, delete items
- each todo item should have:
    - checkbox (done/not done)
    - name
    - notes
    - order
- "Section" is a a special type of todo item, they only have name and order. They cannot be checked off

## Navigation
- User logs in -> Dashboard
- Dashboard contains their todo items
- order is used to sort the items.

## Design
- Use a modern design with interactive feedback like hover
- Allow user to drag to reorder (both items and section items)
- Hover on an idea shows ability to delete
- Double click on item/name allows edit
- Notes should be a smaller text. Notes can be a multi-line text
- Sections should be bold and visually different to act as section headings for the todo items

## Implemented Features

### Core Functionality
- [x] Drag-to-reorder todo items within sections
- [x] Drag-to-reorder sections themselves
- [x] Section creation/editing interface
- [x] Nested item persistence

### Security
- [x] User authentication system
- [x] Session management
- [x] Ownership validation for all resources

### Data Model
```ruby
class TodoItem < ApplicationRecord
  belongs_to :user
  belongs_to :section, class_name: 'TodoItem', optional: true
  has_many :todo_items, foreign_key: :section_id

  # Scopes
  scope :sections, -> { where(is_section: true) }
  scope :standalone, -> { where(is_section: false, section_id: nil) }
end

## Future Roadmap
- [ ] Mobile-optimized drag handles
- [ ] Section collapsing/expanding
- [ ] Due dates and reminders
- [ ] Shared todo lists