defmodule ElixirNotesApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ElixirNotesAppWeb.Telemetry,
      ElixirNotesApp.Repo,
      {DNSCluster, query: Application.get_env(:elixir_notes_app, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ElixirNotesApp.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ElixirNotesApp.Finch},
      # Start a worker by calling: ElixirNotesApp.Worker.start_link(arg)
      # {ElixirNotesApp.Worker, arg},
      # Start to serve requests, typically the last entry
      ElixirNotesAppWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirNotesApp.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ElixirNotesAppWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
