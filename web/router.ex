defmodule AddressLookupFaker.Router do
  use AddressLookupFaker.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", AddressLookupFaker do
    pipe_through :api
  end
end
