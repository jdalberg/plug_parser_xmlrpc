defmodule Plug.Parsers.XMLRPCTest do
  use ExUnit.Case
  use Plug.Test

  doctest Plug.Parsers.XMLRPC

  def xmlrpc_conn(body, content_type \\ "text/xml") do
    conn(:post, "/", body) |> put_req_header("content-type", content_type)
  end

  def parse(conn, opts \\ []) do
    opts = opts
           |> Keyword.put_new(:parsers, [:xmlrpc])
    Plug.Parsers.call(conn, Plug.Parsers.init(opts))
  end

  test "method, 2 params" do
    conn = xmlrpc_conn( %XMLRPC.MethodCall{method_name: "test.sumprod", params: [2,3]} |> XMLRPC.encode! ) |> parse
    assert conn.params.method_name == "test.sumprod"
    assert conn.params.params == [2,3]
  end

  test "method, no params" do
    conn = xmlrpc_conn( %XMLRPC.MethodCall{method_name: "test.noparams", params: []} |> XMLRPC.encode! ) |> parse
    assert conn.params.method_name == "test.noparams"
    assert conn.params.params == []
  end

  test "method, error xml" do
    xml = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><methodCall><methodName>test.sumprod</methodName><params><param><value><int>2</int></value></param><param><value><int>3</int></value></param></paramsfoo></methodCall>"
    conn = xmlrpc_conn( xml ) |> parse
    assert conn.params["_xmlrpc"] == {:error, "Malformed: Tags don't match"}
  end

end
