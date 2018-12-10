## Controllers

The `DashboardController` is the main point of entry for the application.
Throughout the life cycle of the application all calls should be scoped through the `current_user` to prevent exposing data from other users.

In the `EntriesController` form objects are created for the consumption of the views. This approach was chosen over a simple model because
the entry form is actually a collection form. If `listening`, `reading` and `speaking` are all chosen in the `create new entry form` then
three different `Entry` objects are saved to the database. This maximizes simplicity for querying, serializing and managing data.

## API
The api section is exclusively for javascript consumption. This is mostly for chart information(study habits, entries, etc.) and for the languages the current user is studying.
