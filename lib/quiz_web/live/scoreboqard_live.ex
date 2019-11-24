defmodule QuizWeb.ScoreboardLive do
  use Phoenix.LiveView

  def render(assigns) do
    Phoenix.View.render(QuizWeb.ScoreboardView, "index.html", assigns)
  end
end
