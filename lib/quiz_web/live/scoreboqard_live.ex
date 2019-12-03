defmodule QuizWeb.ScoreboardLive do
  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(QuizWeb.ScoreboardView, "index.html", assigns)
  end

  def mount(_, socket) do
    {:ok, assign(socket, teams: initial_teams())}
  end

  defp initial_teams do
    %{
      "1" => %{name: "Team one", score: 0, buzzed?: false},
      "2" => %{name: "Team two", score: 0, buzzed?: false},
      "3" => %{name: "Team three", score: 0, buzzed?: false}
    }
  end

  def handle_event("keydown", %{"key" => key}, socket) when key in ~w(1 2 3 4) do
    teams = socket.assigns.teams |> buzz(key)
    {:noreply, socket |> assign(:teams, teams) |> IO.inspect()}
  end

  defp buzz(teams, key) do
    teams |> put_in([key, :buzzed?], true)
  end

  def handle_event(_event, _args, socket) do
    {:noreply, socket}
  end
end
