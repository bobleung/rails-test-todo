# Rails Test Todo

A Rails application for managing todo items. This project was created from the [rails-base](https://github.com/bobleung/rails-base) template.

## Getting Started

### Prerequisites

* Ruby version: Check `.ruby-version` file
* PostgreSQL
* Node.js and Yarn for JavaScript dependencies

### Setup

1. Clone the repository
   ```
   git clone https://github.com/bobleung/rails-test-todo.git
   cd rails-test-todo
   ```

2. Install dependencies
   ```
   bundle install
   yarn install
   ```

3. Setup database
   ```
   bin/rails db:create db:migrate db:seed
   ```

4. Start the server
   ```
   bin/dev
   ```

## Features

* User authentication system
* Responsive design with Tailwind CSS
* Docker support for development and deployment

## Testing

```
bin/rails test
```

## Deployment

This application is configured for deployment with Kamal.

## License

This project is open source and available under the MIT License.
