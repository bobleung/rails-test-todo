# Todo List Application with Sections

A modern task management application built with Ruby on Rails 8 featuring:

- **Drag-to-reorder functionality** for both todo items and sections
- **Nested sections** implemented through self-referential relationships
- **Authentication system** with secure session management
- **Responsive UI** built with Tailwind CSS
- **Interactive features** using Stimulus.js and SortableJS

## Key Features

✅ **Hierarchical Organization**  
Create sections that can contain multiple todo items

✅ **Intuitive Drag Interface**  
Rearrange items and sections with native drag-and-drop

✅ **Completion Tracking**  
Mark items as complete with persistent checkboxes

✅ **Security First**  
User-specific data scoping and CSRF protection

## Technology Stack

- **Framework**: Ruby on Rails 8
- **Database**: SQLite (development), PostgreSQL (production)
- **Frontend**: Tailwind CSS + Stimulus.js
- **Drag Library**: SortableJS
- **Authentication**: Custom session-based system

## Installation

```bash
bin/setup
rails server
```

Visit `http://localhost:3000` and register a new account

## Deployment

Pre-configured for Fly.io deployment:
```bash
fly launch
fly deploy
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

[Your license information here]
