[
  import_deps: [:ecto, :phoenix, :ash_json_api, :ash_postgres],
  inputs: ["*.{ex,exs}", "priv/*/seeds.exs", "{config,lib,test}/**/*.{ex,exs}"],
  subdirectories: ["priv/*/migrations"]
]
