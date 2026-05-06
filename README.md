# Rails Real-Time Chat App

A modern, real-time chat application built strictly following the "Rails Way" using **Rails 8**, **Hotwire (Turbo & Stimulus)**, and **Action Cable**.

## 🚀 Features

- **Real-time Messaging:** Messages appear instantly for all users in a room without page refreshes.
- **Real-time Room Discovery:** New rooms appear in the sidebar automatically as they are created.
- **Polished UI:** A clean, responsive design using Vanilla CSS with smooth animations.
- **Zero JS Boilerplate:** Leverages Turbo Streams to handle websocket updates without writing custom JavaScript.

## 🛠 Tech Stack

- **Framework:** Ruby on Rails 8
- **Frontend:** Hotwire (Turbo Streams)
- **Styling:** Vanilla CSS (Modern Flexbox/Grid)
- **Real-time:** Action Cable
- **Database:** SQLite (Default)

## 📋 Prerequisites

- Ruby 3.2.0+
- Rails 8.1.3+
- Redis (Recommended for Production Action Cable, though `async` works for local development)

## ⚙️ Setup & Installation

1. **Clone the repository**
2. **Install dependencies:**
   ```bash
   bundle install
   ```
3. **Setup the database:**
   ```bash
   bin/rails db:prepare
   ```
4. **Start the server:**
   ```bash
   bin/dev
   # OR
   bin/rails s
   ```
5. **Open the app:** Visit `http://localhost:3000`

## 🏗 Architecture (The "Rails Way")

### 1. Model-Level Broadcasts
The `Message` and `Room` models use `broadcasts_to` and `after_create_commit` hooks to push HTML snippets through Action Cable.

```ruby
# app/models/message.rb
class Message < ApplicationRecord
  broadcasts_to :room
end
```

### 2. View Subscriptions
Views subscribe to these streams using simple helpers that handle the WebSocket connection under the hood.

```erb
<%# app/views/rooms/show.html.erb %>
<%= turbo_stream_from @room %>
```

### 3. Controller Handlers
Controllers respond to `turbo_stream` formats to perform surgical DOM updates (like clearing a form) while the model handles the broad broadcast to all subscribers.

---

## 🧪 Testing

Run the test suite with:
```bash
bin/rails test
```
