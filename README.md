# Mini Cricket

A single-player, hand-cricket style mini-game built with Flutter (Android).

Tap **Bat** to face a ball. Two numbers spin — yours and the bowler's. If
they match, you're **OUT**; otherwise your number is added to the score.
Play continues for one over (6 balls).

## Game rules

Each ball works like the classic playground "hand cricket" game:

1. The player taps **Bat** to face a delivery.
2. Two random numbers between **0 and 6** are generated — one for the
   player's shot, one for the bowler's delivery — and shown spinning on
   screen for a moment (`"3   vs   5"`).
3. **Numbers match (and aren't both 0) → OUT.** The innings ends
   immediately and the button turns into a red **Restart**.
4. **Numbers don't match → runs scored.** The player's number is added to
   the total. A `0` shows as **"No Runs"**; anything else shows as
   **"N Runs"**.
5. Balls remaining ticks down by one after every non-wicket ball. When it
   hits **0**, the over is over and the game ends (Restart is shown), even
   if the player was never out.

## Requirements

- Flutter SDK (stable channel)
- Android SDK / an Android emulator or device

## Running

```bash
flutter pub get
flutter run
```

## Testing

```bash
flutter test
```

## Project structure

```
lib/
  main.dart                 # The entire app: UI, state and game logic
test/
  widget_test.dart          # Widget tests
```

## Assignment

SE303.3 Mobile Application Development — Day 5.
