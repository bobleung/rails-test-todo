# Rails Base

A modern Ruby on Rails 8 application template with authentication, Docker support, and Kamal deployment.

## Overview

Rails Base is a starter template for Ruby on Rails applications that provides a solid foundation for building web applications quickly. It includes user authentication, modern UI components, and deployment configurations out of the box.

For detailed technical specifications and architecture, please see [SPEC.md](SPEC.md).

## Features

* Complete user authentication system
* Modern UI with TailwindCSS
* Docker containerization support
* Kamal deployment setup
* Multi-database configuration
* Todo list management with sections

## Getting Started

### Requirements

* Rails 8.0.2
* Ruby 3.3.5
* SQLite 3
* Node.js and Yarn

### Setup

1. Clone the repository
   ```bash
   git clone <repository-url>
   cd rails-base
   ```

2. Install dependencies
   ```bash
   bundle install
   ```

3. Setup the database
   ```bash
   bin/rails db:setup
   ```

4. Start the development server
   ```bash
   bin/rails server
   ```

5. Visit http://localhost:3000 in your browser

## Running with Docker

```bash
docker build -t rails-base .
docker run -d -p 80:80 -e RAILS_MASTER_KEY=<value from config/master.key> --name rails-base rails-base
```

## Basic Usage

After setting up the application:

1. Register a new user account at `/register`
2. Log in with your credentials at `/login`
3. Access the dashboard at `/dashboard`
4. Manage your profile at `/profile`
5. Create and manage todo items and sections in the dashboard
   - Add regular todo items to track tasks
   - Create sections to organise your todo items
   - Mark items as complete with a simple checkbox
   - Edit or delete items directly from the dashboard

## Deployment

Basic deployment steps using Kamal:

1. Configure your deployment settings in `.kamal/`
2. Deploy with:
   ```bash
   bundle exec kamal setup
   bundle exec kamal deploy
   ```

For detailed deployment configuration, see [SPEC.md](SPEC.md).

## Testing

Run the test suite with:

```bash
bin/rails test
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

[Your license information here]
