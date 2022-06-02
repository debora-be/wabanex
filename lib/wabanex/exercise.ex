defmodule Wabanex.Exercise do
  use Ecto.Schema
  import Ecto.Changeset

  alias Wabanex.Training

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  @fields [:end_date, :start_date, :user_id]

  schema "exercises" do
    field :name, :string
    field :youtube_video_url, :string
    field :protocol_description, :string
    field :repetitions, :string

    belongs_to :training, Training

    timestamps()
  end

  def changeset (params) do
    %__MODULE__{}
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> unique_constraint([:email])
    |> cast_assoc(:exercises)
  end
end
