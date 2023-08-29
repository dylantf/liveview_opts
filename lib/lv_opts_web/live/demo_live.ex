defmodule LvOptsWeb.DemoLive do
  use LvOptsWeb, :live_view

  @greetings ["hello", "hallo", "hei"]
  @goodbyes ["goodbye", "auf wiedersehen", "ha det bra"]

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       form: to_form(changeset(%{}), as: :demo),
       select1_opts: ["greetings", "goodbyes"],
       select2_opts: []
     ), layout: false}
  end

  @types %{
    select1: :string,
    select2: :string,
    dummy: :string
  }

  def changeset(params) do
    Ecto.Changeset.cast({%{}, @types}, params, [:select1, :select2, :dummy])
  end

  def handle_event("updated", %{"demo" => demo_params}, socket) do
    select2_opts =
      case Map.get(demo_params, "select1") do
        "greetings" -> @greetings
        "goodbyes" -> @goodbyes
        _ -> []
      end

    # Ideally select2 gets reset when select1 updates but we'll leave it off
    # for simplicity

    {:noreply, assign(socket, select2_opts: select2_opts)}
  end

  def handle_event("submitted", %{"demo" => _demo_params}, socket) do
    {:noreply,
     assign(socket,
       form: to_form(changeset(%{}), as: :demo),
       select2_opts: []
     )}
  end

  def render(assigns) do
    ~H"""
    <div class="p-20">
      <.form for={@form} phx-change="updated" phx-submit="submitted" class="space-y-4">
        <.input
          type="select"
          field={@form[:select1]}
          label="select1"
          prompt="Select"
          options={@select1_opts}
        />

        <.input
          type="select"
          field={@form[:select2]}
          label="select2"
          prompt="Select"
          options={@select2_opts}
        />

        <.input type="text" field={@form[:dummy]} label="Some text" />

        <.button type="submit">Submit</.button>
      </.form>
    </div>
    """
  end
end
