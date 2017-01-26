defmodule Plug.Parses.XMLRPC.Mixfile do
  use Mix.Project

  @version "1.0.1"

  def project do
    [app: :ppx,
     version: @version,
     elixir: "~> 1.2.3 or ~> 1.3",
     deps: deps(),
     name: "Plug.Parsers.XMLRPC"]
  end

  # Configuration for the OTP application
  def application do
    [applications: [:logger]]
  end

  def deps do
    [
      {:xmlrpc, "~> 0.9"},
      {:plug, "~> 1.3.0"},
      {:erlsom, "~> 1.4"}
    ]
  end

end
