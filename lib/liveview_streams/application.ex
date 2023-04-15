defmodule LiveviewStreams.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      LiveviewStreamsWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: LiveviewStreams.PubSub},
      # Start Finch
      {Finch, name: LiveviewStreams.Finch},
      # Start the Endpoint (http/https)
      LiveviewStreamsWeb.Endpoint
      # Start a worker by calling: LiveviewStreams.Worker.start_link(arg)
      # {LiveviewStreams.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveviewStreams.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    LiveviewStreamsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
