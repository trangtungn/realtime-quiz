# System Design Document

## Architecture Diagram

![Architecture Diagram](architecture.png)

```mermaid
graph TD;
    A[Web Browser Client] <-->|HTTPS/WSS| F;

    subgraph Application Server
        F[Reverse Proxy & Load Balancer]
        B[Rails Web Servers - Puma]
        C[Action Cable Servers]
    end

    F <-->|HTTP| B;
    F <-->|WebSocket| C;

    subgraph Data Layer
        D[(Databases)]
        E[(Redis Servers)]
        G[Caching Service]
    end

    B <-->|Read/Write| D;
    B <-->|Cache| G;
    B <-->|Pub/Sub| E;
    C <-->|Pub/Sub| E;

    subgraph Monitoring
        H[Monitoring Tools]
        I[Logging Service]
    end

    B --> H;
    C --> H;
    B --> I;
    C --> I;
```

## Key Components

### Rails Application Server
- Web Server: Puma
- Framework: Ruby on Rails 7.1.4 for RESTful APIs
- Language: Ruby 3.2.2
- Frontend framework: Hotwire Turbo, Bootstrap, Action Cable client for WebSocket connections

### Action Cable Server
- Web Server: Puma
- Framework: ActionCable for real-time communication

### Redis Server
- Pub/Sub messaging

### Databases
- SQLite Database (Development)
- PostgreSQL Database (Production)

## Data Flow
![Data Flow](data_flow.png)

```mermaid
sequenceDiagram
    participant Client
    participant WebServer
    participant ActionCable
    participant Redis
    participant Database

    Client->>WebServer: POST /quizzes/:token/join
    WebServer->>Database: Create participation record
    WebServer->>Redis: Publish participant joined
    Redis->>ActionCable: Notify new participant
    ActionCable->>Client: Broadcast update to all clients
```

## Technology Justification

### Ruby on Rails framework
- Rapid development
- Built-in support for Action Cable
- Built-in Hotwire Turbo for frontend framework

### Action Cable framework
- Real-time communication

### Puma Web Server
- Multi-threaded web server
- Supports Action Cable

### RDBMS Databases
- SQLite (Development): Lightweight and easy to set up
- PostgreSQL (Production): for better performance and heavy load

### Redis
- Pub/Sub messaging
- Fast in-memory data store

## Scaling Considerations

### Horizontal Scaling
- Multiple Rails application servers behind a load balancer
- Separate Action Cable servers for WebSocket handling
- Redis for pub/sub ensures message consistency across servers

### Database Scaling
- Development uses SQLite for simplicity
- Production should use PostgreSQL for better performance and concurrent access
- Proper indexing on frequently accessed columns (see schema.rb)

### Caching Strategy
- Redis can be used for caching quiz data
- Action Cable subscription data stored in Redis
