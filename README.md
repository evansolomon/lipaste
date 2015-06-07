# Lipaste

Little command line tool to upload chess games in PGN format to the Lichess analyzer.

## Installation

```
gem install lipaste
```

## Usage

```
# Optionally login to save uploaded games to your Lichess account
# You only need to do this once
lipaste login

# Upload the newest .pgn file from ~/Downloads
lipaste

# Upload a specific PGN file
lipaste -p /path/to/game.pgn

# Delete saved credentials if any exist
lipaste logout
```
