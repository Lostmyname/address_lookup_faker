defmodule AddressLookupFaker.AddressController do
  use AddressLookupFaker.Web, :controller

  def index(conn,
    %{ "searchterms" => "Lost My Name 22 ParkHill Road London RE 9AP"}) do

    conn
      |> put_status(:ok)
      |> put_resp_content_type("text/json")
      |> json(retrieve_data("multiple_addresses.json"))
  end

  def index(conn,
    %{ "searchterms" => "LMN 38-50 ParkHill Road London RE 9AP"}) do

    conn
      |> put_status(:ok)
      |> put_resp_content_type("text/json")
      |> json(retrieve_data("single_address.json"))
  end

  def index(conn, _params) do
    json conn, []
  end

  defp retrieve_data(file_name) do
    Application.app_dir(:address_lookup_faker,
                        "priv/json/#{file_name}")
      |> File.read!
      |> Poison.decode!
  end
end
