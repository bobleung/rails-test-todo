# Rails Base Technical Specifications

This document outlines the technical specifications, architecture, and design decisions of the Rails Base application.

## Technology Stack

### Backend
- **Ruby**: 3.3.5
- **Rails**: 8.0.2
- **Database**: SQLite 3 (with multi-database configuration for production)
- **Authentication**: Rails 8 built-in authentication system using `has_secure_password`
- **Web Server**: Puma with Thruster for HTTP asset caching/compression

### Frontend
- **CSS Framework**: TailwindCSS 2.0
- **JavaScript Framework**: Hotwire (Turbo and Stimulus)
- **Asset Pipeline**: Propshaft
- **JavaScript Module System**: Import Maps

### Infrastructure
- **Containerization**: Docker
- **Deployment**: Kamal
- **CI/CD**: GitHub Actions

## Architecture

### Design Principles
- **Convention over Configuration**: Following Rails conventions for code organization
- **RESTful Resources**: Standard REST patterns for controllers and routes
- **Database-backed Adapters**: Using Solid* gems for database-backed services

### Application Structure
The application follows the standard Rails MVC (Model-View-Controller) architecture:

- **Models**: Located in `app/models/`
- **Views**: Located in `app/views/`
- **Controllers**: Located in `app/controllers/`
- **JavaScript**: Located in `app/javascript/`
- **Stylesheets**: Managed through TailwindCSS

### Database Schema

#### Core Tables
- `users`: Stores user accounts
  - `email_address`: String (unique, normalized)
  - `password_digest`: String (bcrypt hashed)
  - `first_name`: String
  - `last_name`: String
  - Timestamps

- `sessions`: Stores user sessions
  - `user_id`: Foreign key to users
  - `ip_address`: String
  - `user_agent`: String
  - Timestamps

#### Multi-Database Configuration
- **Primary Database**: `production.sqlite3` - Main application data
- **Cache Database**: `production_cache.sqlite3` - For Solid Cache
- **Queue Database**: `production_queue.sqlite3` - For Solid Queue
- **Cable Database**: `production_cable.sqlite3` - For Solid Cable (Action Cable)

### Authentication Architecture

The authentication system leverages Rails 8's built-in authentication features:

1. **User Model**:
   - Uses Rails' `has_secure_password` for password hashing via bcrypt
   - Built-in email normalization via `normalizes` API
   - Standard validations using `validates` with `URI::MailTo::EMAIL_REGEXP`

2. **Session Management**:
   - Built-in session storage with database-backed sessions
   - Automatic cookie management with security headers
   - CSRF protection via `authenticity_token`

3. **Controller Integration**:
   - Uses Rails' `authenticate_user!` before_action
   - Built-in password reset flows
   - Standardized error handling for authentication failures

4. **Security Features**:
   - Automatic password complexity requirements
   - Session fixation protection
   - Timeoutable sessions

### API Design

While not exposing a formal API, the application follows RESTful conventions:

#### Authentication Routes
- `GET /login` → `sessions#new`
- `POST /sessions` → `sessions#create`
- `DELETE /sessions` → `sessions#destroy`

#### User Management Routes
- `GET /register` → `registrations#new`
- `POST /registrations` → `registrations#create`
- `GET /profile` → `profiles#show`
- `PATCH /profile` → `profiles#update`

#### Password Management Routes
- `GET /password/reset` → `passwords#new`
- `POST /password/reset` → `passwords#create`
- `GET /password/edit` → `passwords#edit`
- `PATCH /password` → `passwords#update`

## Docker Architecture

The Docker configuration uses a multi-stage build process:

1. **Base Stage**:
   - Uses Ruby 3.3.5 slim image
   - Installs minimal system dependencies

2. **Build Stage**:
   - Installs build dependencies
   - Installs Ruby gems
   - Precompiles assets and bootsnap
   - No secrets required during build

3. **Final Stage**:
   - Copies artifacts from build stage
   - Configures non-root user (UID/GID 1000)
   - Sets up entry point and default command
   - Uses Thruster for enhanced performance

### Security Considerations
- Non-root user in container
- Multi-stage build to minimize attack surface
- No secrets in Dockerfile
- Minimal system dependencies

## Kamal Deployment

Kamal deployment is configured for zero-downtime deployments:

1. **Configuration**: `.kamal/` directory contains deployment configuration
2. **Secret Management**: Encrypted secrets for production environment
3. **Rolling Deployments**: Zero-downtime deployments with health checks
4. **Volume Management**: Persistent volumes for database storage

## Performance Optimizations

- **Bootsnap**: Precompiles application code for faster boot times
- **Thruster**: HTTP asset caching/compression for Puma
- **Solid Cache**: Database-backed cache adapter
- **Solid Queue**: Database-backed job queue for background processing
- **Import Maps**: Avoids JavaScript bundling for faster page loads

## Security Measures

- **Password Security**: bcrypt hashing via `has_secure_password`
- **Session Management**: HTTP-only cookies with SameSite=Lax
- **Modern Browser Requirements**: Only allows browsers supporting key security features
- **Static Analysis**: Brakeman for security vulnerability detection
- **SQL Injection Protection**: ActiveRecord query methods

## Development Tools

- **Brakeman**: Static analysis for security vulnerabilities
- **RuboCop Rails Omakase**: Rails-specific code style enforcement
- **Debug**: Ruby debugging tools
- **Web Console**: In-browser debugging for development
- **Capybara/Selenium**: System testing tools

## Testing Architecture

- **Unit Tests**: Models, helpers, and other isolated components
- **Controller Tests**: Testing controller actions and responses
- **System Tests**: End-to-end testing with browser simulation

## Key Technical Decisions

1. **SQLite for Production**: Using SQLite with proper volume management for simplicity
2. **Multi-database Configuration**: Separate databases for different concerns
3. **Rails Authentication**: Using Rails 8's built-in authentication system instead of external gems
4. **Solid* Adapters**: Database-backed adapters for durability
5. **Propshaft**: Modern asset pipeline over legacy Sprockets
6. **Import Maps**: Direct module imports over bundling
