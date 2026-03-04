# cctime

Calculate how much time you've spent working with Claude Code, based on your local session logs.

## Install

### Homebrew (macOS / Linux)

```sh
brew install ShahadIshraq/tap/cctime
```

### Download binary

Grab the latest binary from [GitHub Releases](https://github.com/ShahadIshraq/cctime/releases):

```sh
# macOS (Apple Silicon)
curl -fsSL https://github.com/ShahadIshraq/cctime/releases/latest/download/cctime-darwin-arm64.tar.gz | tar xz
sudo mv cctime-darwin-arm64 /usr/local/bin/cctime

# macOS (Intel)
curl -fsSL https://github.com/ShahadIshraq/cctime/releases/latest/download/cctime-darwin-x64.tar.gz | tar xz
sudo mv cctime-darwin-x64 /usr/local/bin/cctime

# Linux (x64)
curl -fsSL https://github.com/ShahadIshraq/cctime/releases/latest/download/cctime-linux-x64.tar.gz | tar xz
sudo mv cctime-linux-x64 /usr/local/bin/cctime

# Windows (x64, PowerShell)
Invoke-WebRequest -Uri https://github.com/ShahadIshraq/cctime/releases/latest/download/cctime-windows-x64.zip -OutFile cctime.zip
Expand-Archive cctime.zip -DestinationPath .
Move-Item cctime-windows-x64.exe "$env:LOCALAPPDATA\Microsoft\WindowsApps\cctime.exe"
```

### npm (requires Node.js >= 18)

```sh
npx cctime
```

Or install globally:

```sh
npm install -g cctime
```

## Usage

```
cctime [options]
```

| Flag | Description | Default |
|------|-------------|---------|
| `--today` | Show today's work time | (default) |
| `--yesterday` | Show yesterday's work time | |
| `--week` | Show current week (Mon–Sun) | |
| `--month` | Show current month | |
| `--from <YYYY-MM-DD>` | Start date | today |
| `--to <YYYY-MM-DD>` | End date | today |
| `--pause <minutes>` | Inactivity gap to split sessions | 10 |
| `--overlap merge\|accumulate` | Cross-project overlap handling | merge |
| `--project <path>` | Filter to a project directory (repeatable) | |
| `--no-subagents` | Exclude subagent (Task tool) activity | |
| `--claude-dir <path>` | Override `~/.claude` directory | |
| `--version`, `-v` | Show version number | |
| `--help`, `-h` | Show help message | |

## Examples

```sh
# Today's total
cctime

# All of February
cctime --from 2026-02-01 --to 2026-02-28

# This week, one project only
cctime --week --project ~/workspace/myapp

# Tighter session gap, accumulate overlaps
cctime --pause 5 --overlap accumulate

# Yesterday, no subagent time
cctime --yesterday --no-subagents
```

## Sample Output

```
=== Claude Code Work Time Report ===
Period: 2026-03-03 to 2026-03-03

  2026-03-03  3h 02m
    09:15 - 11:29  (2h 14m)
    14:00 - 14:48  (0h 48m)

  Total:      3h 02m
=================================
```

## How It Works

1. Reads JSONL conversation logs from `~/.claude/`
2. Extracts message timestamps per project
3. Clusters timestamps into work blocks using the pause threshold
4. Merges (or accumulates) overlapping blocks across projects
5. Reports total focused work time per day

## Requirements

- Node.js >= 18
- Claude Code installed and used at least once

## License

MIT
