defmodule ElixirNotesApp.Repo do
  use Ecto.Repo,
    otp_app: :elixir_notes_app,
    adapter: Ecto.Adapters.Postgres
end
