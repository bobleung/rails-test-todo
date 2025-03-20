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