defmodule LvOpts.Repo do
  use Ecto.Repo,
    otp_app: :lv_opts,
    adapter: Ecto.Adapters.Postgres
end
