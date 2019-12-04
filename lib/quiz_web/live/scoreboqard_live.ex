defmodule QuizWeb.ScoreboardLive do
  use Phoenix.LiveView
  alias QuizWeb.Endpoint

  def render(assigns) do
    Phoenix.View.render(QuizWeb.ScoreboardView, "index.html", assigns)
  end

  def mount(_, socket) do
    {:ok, assign(socket, teams: initial_teams(), state: :question)}
  end

  defp initial_teams do
    %{
      "1" => %{name: "Team one", score: 0, buzzed?: false},
      "2" => %{name: "Team two", score: 0, buzzed?: false},
      "3" => %{name: "Team three", score: 0, buzzed?: false}
    }
  end

  def handle_event("keydown", %{"key" => key}, %{assigns: %{state: :question}} = socket)
      when key in ~w(1 2 3 4) do
    Endpoint.broadcast!("buzzer", "buzz", %{})
    teams = socket.assigns.teams |> put_in([key, :buzzed?], true)
    {:noreply, socket |> assign(teams: teams, state: :answer)}
  end

  def handle_event("keydown", %{"key" => "["}, %{assigns: %{state: :answer}} = socket) do
    teams = socket.assigns.teams |> award_points(-1)
    {:noreply, socket |> assign(teams: teams, state: :question)}
  end

  def handle_event("keydown", %{"key" => "]"}, %{assigns: %{state: :answer}} = socket) do
    teams = socket.assigns.teams |> award_points(1)
    {:noreply, socket |> assign(teams: teams, state: :question)}
  end

  def handle_event("keydown", %{"key" => "Escape"}, %{assigns: %{state: :answer}} = socket) do
    teams = socket.assigns.teams |> award_points(0)
    {:noreply, socket |> assign(teams: teams, state: :question)}
  end

  defp award_points(teams, points), do: teams |> Enum.into(%{}, &award_if_buzzed(&1, points))

  defp award_if_buzzed({id, %{buzzed?: true} = team}, points) do
    {id, %{team | score: team.score + points, buzzed?: false}}
  end

  defp award_if_buzzed({id, team}, _), do: {id, %{team | buzzed?: false}}

  def handle_event(_event, _args, socket) do
    {:noreply, socket}
  end
end
