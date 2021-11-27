defmodule EtlCrossCommerce.Repo do
  use Ecto.Repo,
    otp_app: :etl_cross_commerce,
    adapter: Ecto.Adapters.Postgres
end
