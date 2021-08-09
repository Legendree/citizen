# Citizen - Super basic Cowboy example in Elixir

In the past week I wondered, how does a simple websocket implementation looks like with Cowboy, no tutorials are available that use a plain example, so I created a small repo with all you need (probably).

## Plain & Simple

One dependency - Cowboy

- Is it useful? To somebody, maybe.
- Was it necessesary? Absoultely not.
- Was it worth it? Absolutely yes.

## Usage

1. Clone the reposetory
2. Run via `iex -S mix`
3. Use a websocket client to connet wscat is a possibility
4. Connect to `ws://localhost:4000/websocket`

Shortly after a succesful connection you will get a message from the socket, also I've added a simple function to match different scenarios e.g.

```elixir
  defp handle_info({:greet, msg}, state) do
    :erlang.start_timer(1000, self(), {:add, "Websockets rock!"})
    {:ok, msg, state}
  end

  defp handle_info({:add, msg}, state) do
    # make it tick
    :erlang.start_timer(1000, self(), {:add, "Websockets rock! as a tick ;)"})
    {:ok, "Howdy a cool message from Cowboy: #{msg}", state}
  end
```

For any real world usage, one would extract Cowboy's initializting functions from `application.ex` create a GenServer and start the process from there, add it to the supervision tree and treat Cowboy's stop function.

```elixir
cowboy:stop_listener(http)
```

I might extend it a bit later and add it myself as a nice example, or maybe not.

p.s. why did I called it 'Citizen' like its some kind of library? I don't know I just like the sound of it leave me alone.
