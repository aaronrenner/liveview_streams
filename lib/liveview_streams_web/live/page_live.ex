defmodule LiveviewStreamsWeb.PageLive do
  use LiveviewStreamsWeb, :live_view

  @max_list_size 3000

  def render(assigns) do
    ~H"""
    <ul id="my-list" phx-update="stream">
      <li :for={{dom_id, book} <- @streams.books} id={dom_id}>
        <div class="hello-world"><%= book.id %></div>
        <div class="hello-world"><%= book.name %></div>
      </li>
    </ul>
    """
  end

  #
  # Option 1 : Memory gets to 5.1 MB
  #

  def mount(_params, _session, socket) do
    books = Enum.map(1..@max_list_size, &%{id: &1, name: "Book #{&1}"})
    {:ok, stream(socket, :books, books)}
  end

  #
  # Option 2 : Memory gets to 1.1 MB
  #

  # def mount(_params, _session, socket) do
  #   send(self(), :tick)
  #   {:ok, socket |> assign(:n, 1) |> stream(:books, [])}
  # end

  # def handle_info(:tick, socket) do
  #   id = socket.assigns.n
  #   book = %{id: id, name: "Book #{id}"}

  #   if id < @max_list_size do
  #     send(self(), :tick)
  #   end

  #   {:noreply, socket |> assign(:n, id + 1) |> stream_insert(:books, book, at: -1)}
  # end
end
