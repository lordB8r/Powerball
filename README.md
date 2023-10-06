# Lottery

This was a quick project to read the historical winning lottery numbers, available [here](https://data.ny.gov/Government-Finance/Lottery-Powerball-Winning-Numbers-Beginning-2010/d6yy-54nr).

The data can be in any format, I'm using CSV.

## Installation

To get this stood up, the project is currently built on Elixir 1.15, using Erlang 25.0.3.

Simply checkout the project, then cd into the directory, and run `mix deps.get`

Download the dataset and put it into this directory. I renamed my to `powerball.csv`

Now just `iex -S mix`, and run the following:

```elixir
iex(1)> Lottery.read_csv("../../powerball.csv")
[
  powerball_frequencies: [
    {"24",68},
    ...
  ],
  winning_number_frequencies: [
    {"36",140},
    ...
  ]
]
```

That's it. It's just a frequency generator. I had fun in the 30 minutes it took to build, hope you enjoy!

