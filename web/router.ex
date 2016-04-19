defmodule AddressLookupFaker.Router do
  use AddressLookupFaker.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/pcw", AddressLookupFaker do
    pipe_through :api

    get "/:searchkey/address/:country_code/search", AddressController, :index
  end
end
