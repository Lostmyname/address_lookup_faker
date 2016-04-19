defmodule ListingAddressesintegrationTest do
	use AddressLookupFaker.ConnCase

  setup do
    {:ok, conn: Phoenix.ConnTest.conn()}
  end

  test "looking up an address with multple results" do
    url = build_url("Lost%20My%20Name%2022%20ParkHill%20Road%20London%20RE%209AP")
		conn = get conn, url

    assert json_response(conn, 200) == retrieve_data("multiple_addresses.json")
    assert conn.status == 200
  end

  test "looking up an address with a single result" do
    url = build_url("LMN%2038-50%20ParkHill%20Road%20London%20RE%209AP")
		conn = get conn, url

    assert json_response(conn, 200) == retrieve_data("single_address.json")
    assert conn.status == 200
  end

  test "looking up an address with no results" do
    url = build_url("BOOM%2038-50%20Pritchards%20Road%20London%20E2%209AP")

		conn = get conn, url

    assert json_response(conn, 200) == []
    assert conn.status == 200
  end

  # how can we remove this duplication
  defp retrieve_data(file_name) do
    Application.app_dir(:address_lookup_faker,
                        "priv/json/#{file_name}")
      |> File.read!
      |> Poison.decode!
  end

	defp build_url(searchterms) do
    "/pcw/MY-KEY/address/FR/search?searchterms=#{searchterms}"
	end
end
