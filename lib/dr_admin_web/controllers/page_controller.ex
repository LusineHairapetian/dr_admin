defmodule DrAdminWeb.PageController do
  use DrAdminWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
