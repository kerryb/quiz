defmodule QuizWeb.BuzzerChannel do
  use QuizWeb, :channel

  def join("buzzer", _payload, socket) do
    {:ok, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (buzzer:lobby).
  def handle_in("buzz", payload, socket) do
    IO.inspect(payload)
    {:noreply, socket}
  end
end
