# timer — oh-my-zsh plugin

A minimal command execution timer for [oh-my-zsh](https://ohmyz.sh/). After each command finishes, it prints the elapsed time right above your prompt.

```
$ sleep 2.5
Time: 2.500s
$
```

## Installation

1. Clone into your oh-my-zsh custom plugins directory:

   ```sh
   git clone https://github.com/ty-cs/timer \
     ~/.oh-my-zsh/custom/plugins/timer
   ```

2. Add `timer` to the plugins list in your `~/.zshrc`:

   ```sh
   plugins=(... timer)
   ```

3. Reload your shell:

   ```sh
   source ~/.zshrc
   ```

## Configuration

Set these variables in your `~/.zshrc` **before** sourcing oh-my-zsh (or anywhere in your config):

| Variable           | Default                          | Description                                           |
|--------------------|----------------------------------|-------------------------------------------------------|
| `TIMER_THRESHOLD`  | `0` (always show)                | Minimum elapsed seconds before the timer is displayed |
| `TIMER_PRECISION`  | `3`                              | Decimal places for the seconds value                  |
| `TIMER_COLOR`      | `white`                          | Any key from oh-my-zsh's `$fg[]` array (e.g. `cyan`, `yellow`, `red`).         |
| `TIMER_FORMAT`     | `"Time: %s"`                     | Output format; use `%s` as the placeholder.                                     |
| `TIMER_SKIP_CMDS`  | `()` (none)                      | List of commands to skip timing (e.g. `(clear vi vim)`).                        |

### Examples

Only show the timer for commands that take longer than 3 seconds:

```sh
TIMER_THRESHOLD=3
```

Change the color to cyan:

```sh
TIMER_COLOR=cyan
```

Show two decimal places with a custom label:

```sh
TIMER_PRECISION=2
TIMER_FORMAT="▶ %s"
```

Skip timing for specific commands:

```sh
TIMER_SKIP_CMDS=(clear vi vim)
```

## How it works

The plugin hooks into zsh's `preexec` (records `$EPOCHREALTIME` when a command starts) and `precmd` (computes the difference and prints the formatted duration).

## License

MIT
