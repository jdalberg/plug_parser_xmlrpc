defmodule Plug.Parsers.XMLRPC do
  @moduledoc """
  Parses XMLRPC request body.

  An empty request body is parsed as an empty map.
  """

  @behaviour Plug.Parsers
  import Plug.Conn

  def parse(conn, "text", "xml", _headers, opts) do
    decoder = Keyword.get(opts, :xmlrpc_decoder, XMLRPC)
    conn
    |> read_body(opts)
    |> decode(decoder)
  end

  def parse(conn, _type, _subtype, _headers, _opts) do
    {:next, conn}
  end

  defp decode({:more, _, conn}, _decoder) do
    {:error, :too_large, conn}
  end

  defp decode({:error, :timeout}, _decoder) do
    raise Plug.TimeoutError
  end

  defp decode({:error, _}, _decoder) do
    raise Plug.BadRequestError
  end

  defp decode({:ok, "", conn}, _decoder) do
    {:ok, %{}, conn}
  end

  defp decode({:ok, body, conn}, decoder) do
    decoded = decoder.decode(body)
    case decoder.decode(body) do
      {:ok,terms} when is_map(terms) ->
        {:ok, terms, conn}
      terms ->
        {:ok, %{"_xmlrpc" => terms}, conn}
    end
  rescue
    e -> raise Plug.Parsers.ParseError, exception: e
  end
end
