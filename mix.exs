defmodule Plug.Parses.XMLRPC.Mixfile do
  use Mix.Project

  @version "1.0.2"

  def project do
    [app: :ppx,
     version: @version,
     elixir: "~> 1.7",
     deps: deps(),
     description: "An xmlrpc parser for xmlrpc requests based on Plug",
     package: package(),
     name: "Plug.Parsers.XMLRPC"]
  end

  # Configuration for the OTP application
  def application do
    [applications: [:logger, :plug]]
  end  
  
  defp package do
    [
      maintainers: ["Jesper Dalberg"],
      licenses: ["Artistic"],
      links: %{"GitHub" => "https://github.com/jdalberg/plug_parser_xmlrpc"}
    ]
  end

  def deps do
    [
      {:xmlrpc, "~> 1.0"},
      {:plug, "~> 1.6"},
      {:erlsom, "~> 1.4"}
    ]
  end

end
