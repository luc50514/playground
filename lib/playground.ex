defmodule Playground do

  def hello do
    :world
  end

  def start do
    spawn(fn -> loop(0) end)
    {:ok, "spawned process"}
  end

  def view(server_pid) do
    IO.puts(inspect server_pid)
    IO.puts(inspect self())
    send(server_pid, {:view, self()})
    value = receive do
      {:response, value} ->
        value
    end

    value
  end
  defp loop(current) do
    IO.puts("start looping")
    IO.puts("loop: #{inspect self()}" )
    recievedvalue = receive do
      {:view, caller_pid} ->
        send(caller_pid, {:response, current})
        current
    end
    loop(recievedvalue)
  end
end
