defmodule GluonExample.User do
  use Ash.Resource, data_layer: AshPostgres.DataLayer, notifiers: [Gluon.AshNotifier]

  postgres do
    table "users"
    repo GluonExample.Repo
  end

  attributes do
    uuid_primary_key(:id)

    attribute(:name, :string)

    attribute(:email, :string,
      allow_nil?: false,
      constraints: [
        # Note: This regex is just an example
        match: ~r/^[\w.!#$%&’*+\-\/=?\^`{|}~]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*$/i
      ]
    )
  end

  relationships do
    has_many :tweets, GluonExample.Tweet, destination_field: :user_id
  end

  actions do
    create(:create)
    read(:read, pagination: [offset?: true])
    update(:update)
    destroy(:destroy)
  end
end
