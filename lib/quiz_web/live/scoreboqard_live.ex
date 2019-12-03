defmodule QuizWeb.ScoreboardLive do
  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(QuizWeb.ScoreboardView, "index.html", assigns)
  end

  def mount(_, socket) do
    {:ok, assign(socket, teams: initial_teams())}
  end

  defp initial_teams do
    [
      %{id: 1, name: "Team one", score: 0, buzzed?: false},
      %{id: 2, name: "Team two", score: 0, buzzed?: false},
      %{id: 3, name: "Team three", score: 0, buzzed?: false}
    ]
  end
end
