defmodule WabanexWeb.Schema.Types.Root do
  use Absinthe.Schema.Notation

  alias WabanexWeb.Resolvers

  alias Resolvers.User, as: UserResolver
  alias Resolvers.Training, as: TrainingResolver

  alias Crudry.Middlewares.TranslateErrors
  alias WabanexWeb.Schema.Types

  import_types Types.User
  import_types Types.Training
  import_types Types.Custom.UUID4

  object :root_query do
    field :get_user, type: :user do
      arg :id, non_null(:uuid4)

      resolve fn params, context -> UserResolver.get(params, context) end
    end
  end

  object :root_mutation do
    field :create_user, type: :user do
      arg :input, non_null(:create_user_input)

      resolve fn params, context -> UserResolver.create(params, context) end
      middleware TranslateErrors
    end

    field :create_training, type: :training do
      arg :input, non_null(:create_training_input)

      resolve fn params, context -> TrainingResolver.create(params, context) end
      middleware TranslateErrors
    end
  end
end
