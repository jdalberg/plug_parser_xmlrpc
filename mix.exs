defmodule Plug.Parses.XMLRPC.Mixfile do
  use Mix.Project

  @version "1.0.2"

  def project do
    [app: :ppx,
     version: @version,
     elixir: "~> 1.7",
     deps: deps(),
     name: "Plug.Parsers.XMLRPC"]
  end

  # Configuration for the OTP application
  def application do
    [applications: [:logger, :plug]]
  end

  def deps do
    [
      {:xmlrpc, "~> 1.0"},
      {:plug, "~> 1.6"},
      {:erlsom, "~> 1.4"}
    ]
  end

end
