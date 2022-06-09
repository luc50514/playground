defmodule Playground do

  def hello do
    :world
  end

  def start do
    spawn(fn -> loop(0) end)
  end

  def start(beginningvalue) do
    spawn(fn -> loop(beginningvalue) end)
  end

  def view(server_pid) do
    send(server_pid, {:view, self()})
    receive do
      {:response, value} ->
        value
    end
  end
  def add(server_pid, value) do
    send(server_pid, {:add, value})
    view(server_pid)
  end
  def subtract(server_pid, value) do
    send(server_pid, {:subtract, value})
    view(server_pid)
  end
  def division(server_pid, value) do
    send(server_pid, {:division, value})
    view(server_pid)
  end
  def multiply(server_pid, value) do
    send(server_pid, {:multiply, value})
    view(server_pid)
  end
  defp loop(current) do
    recievedvalue = receive do
      {:view, caller_pid} ->
        send(caller_pid, {:response, current})
        current
      {:add, value} -> current + value
      {:subtract, value} -> current - value
      {:division, value} -> current / value
      {:multiply, value} -> current * value
    end
    loop(recievedvalue)
  end
end
