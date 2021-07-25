defmodule GluonExample.Tweet do
  use Ash.Resource, data_layer: AshPostgres.DataLayer, notifiers: [Gluon.AshNotifier]

  postgres do
    table "tweets"
    repo GluonExample.Repo
  end

  attributes do
    uuid_primary_key :id

    attribute :body, :string do
      allow_nil? false
      constraints max_length: 255
    end

    # Alternatively, you can use the keyword list syntax
    # You can also set functional defaults, via passing in a zero
    # argument function or an MFA
    attribute :public, :boolean, allow_nil?: false, default: false

    # This is set on create
    create_timestamp :inserted_at
    # This is updated on all updates
    update_timestamp :updated_at

    # `create_timestamp` above is just shorthand for:
    # attribute :inserted_at, :utc_datetime_usec,
    #   private?: true,
    #   writable?: false,
    #   default: &DateTime.utc_now/0
  end

  relationships do
    belongs_to :user, GluonExample.User
  end

  actions do
    create :create
    read :read
    update :update
    destroy :destroy
  end
end
