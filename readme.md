# keep-it-safe

game on itch.io: [link](https://thewarlock.itch.io/keep-it-safe)

Stipulation: Text based

## TODO

### First Loop

- Enter scene, move from left to right, transition to the next

- Scene
  - Enter, exit events
  - Ground
  - Parallax (3 layers)
  - Call scene framwework hooks (load assets, characters, events, etc.)

- UI
  - TextBox for dialogue

- Mechanics
  - Move the pixel around the character
  - Dialogue (use dialogic?)

- Scene framework
  - Scene Graph
    - Define transitions, allow randomness
  - Procedures
    - Load assets
  - Per Scene
    - Game elements
      - Ground (Flat/slanted?)
      - Characters (e.g. Troll, ghosts)
      - Scripted events
        - Lose/Win condition (default win con is to move all the way to the right)
    - Assets
      - Foreground (1 sprite)
      - Background (1 sprite)
      - Middle ground
        - brushes, etc

- Push release with `./push_release.sh`

### Extra

- itch.io
  - Rename the game
  - Write a short description
  - Make a nice cover image (630x500)
  - Add screenshots (recommended: 3-5)
  - Pick a genre
  - Add a tag or two
  - Publish a devlog on instagram

### Useful links

- [Color palette](https://colorsupplyyy.com/app)
- [Hex grids](https://www.redblobgames.com/grids/hexagons/)

### Meta

- Tackle multiplayer in HTML5
  - https://www.reddit.com/r/godot/comments/bux2hs/how_to_use_godots_high_level_multiplayer_api_with/
