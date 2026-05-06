# Project Instructions: Rails Chat App

## 🏗 Architecture & Conventions

- **Real-time Engine:** Always use **Turbo Streams** over Action Cable for real-time updates. Avoid writing custom Action Cable channels or Stimulus controllers for basic data synchronization unless Turbo Streams cannot fulfill the requirement.
- **Styling:** Maintain the **Vanilla CSS** approach. Variables are defined in `app/assets/stylesheets/app.css`. Prefer modern CSS features (Grid, Flexbox, Custom Properties) over utility frameworks like Tailwind unless explicitly requested.
- **Model Logic:** Keep real-time broadcasting logic within the models using `after_create_commit` or the `broadcasts_to` shorthand to ensure consistency across all entry points (Web, Console, API).
- **Views:**
  - Use partials for all repeatable elements (`_room.html.erb`, `_message.html.erb`).
  - Use `dom_id(record)` for container IDs to ensure Turbo can target them accurately.

## 🛠 Workflows

- **Adding a new real-time feature:**
  1. Define the broadcast in the Model.
  2. Add `turbo_stream_from` to the relevant view.
  3. Ensure the partial for the record exists in the standard location (`app/views/records/_record.html.erb`).
- **CSS Changes:** Always check `app/assets/stylesheets/app.css` first to reuse existing variables and maintain the clean, "alive" aesthetic.

## 📝 Troubleshooting

- **Messages not appearing:** Ensure `bin/rails dev:cache` is enabled if using certain caching features, and verify that the `turbo_stream_from` tag is present in the rendered HTML.
- **Styling issues:** Check the `app.css` rename in `app/views/layouts/application.html.erb`.
