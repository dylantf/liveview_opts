defmodule LvOpts.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      LvOptsWeb.Telemetry,
      # Start the Ecto repository
      # LvOpts.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: LvOpts.PubSub},
      # Start Finch
      {Finch, name: LvOpts.Finch},
      # Start the Endpoint (http/https)
      LvOptsWeb.Endpoint
      # Start a worker by calling: LvOpts.Worker.start_link(arg)
      # {LvOpts.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LvOpts.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LvOptsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
