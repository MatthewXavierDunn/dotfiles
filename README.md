# Dotfiles

My dotfiles for fast configuration. Simply clone this repository and follow the
setup steps.

## Prerequisites

 - [`neovim`](https://neovim.io/) for the terminal based text editor;
 - [`tmux`](https://github.com/tmux/tmux/wiki) for terminal multiplexing.

## Setup

1. Clone the repo;
2. Move each repo directory into your `~/.config` directory;
3. Move the `.tmux.conf` file into your home, `~`, directory;
4. Install the tmux plugin manager - tpm:
  ```bash
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ```
5. Run both tmux and nvim to perform the initial setup and installation of all
   specified plugins.

## Key Bindings

All `<leader>` tags represent the space key which has been set to be the leader
key for neovim.

### tmux Specific

| Key          | Explanation                   |
|--------------|-------------------------------|
| `<Ctrl-a>r`  | Refresh tmux config.          |
| `<Ctrl-a>h`  | Resize tmux pane leftwards.   |
| `<Ctrl-a>j`  | Resize tmux pane downwards.   |
| `<Ctrl-a>k`  | Resize tmux pane upwards.     |
| `<Ctrl-a>l`  | Resize tmux pane rightwards.  |
| `<Ctrl-a>\|` | Split tmux pane horizontally. |
| `<Ctrl-a>-`  | Split tmux pane vertically.   |
| `<Alt>t`     | Open new tmux tab.            |
| `<Alt><n>`   | Go to `n`-th tmux tab.        |
| `<Alt><r>`   | Rename current tab.           |

### neovim Specific

| Key          | Explanation                                                   |
|--------------|---------------------------------------------------------------|
| `<leader>nt` | Opens the file `oil.nvim` file explorer as a floating buffer. |
| `<leader>ca` | See code actions.                                             |
| `<leader>rn` | Rename symbol.                                                |
| `<leader>d`  | Show line diagnostics.                                        |
| `[d`         | jump to previous diagnostic.                                  |
| `]d`         | jump to next diagnostic.                                      |
| `K`          | Show documentation for symbol under cursor.                   |
| `<leader>ff` | Fuzzy find file in current directory.                         |
| `<leader>fs` | Fuzzy find string in current directory.                       |
| `<leader>fc` | Find string after cursor in current directory.                |
| `<leader>fb` | List buffers.                                                 |
| `<leader>fh` | List help tags.                                               |
| `gf`         | Show definition.                                              |
| `gD`         | Go to declaration.                                            |
| `gd`         | Preview definition.                                           |
| `gi`         | Go to implementation.                                         |
| `<Ctrl>o`    | See outline on right hand side.                               |

### Shared Key Bindings

The following movments are standardised across tmux, neovim, and any subwindows
in the neovim instance.

| Key       | Explanation                             |
|-----------|-----------------------------------------|
| `<Ctrl>h` | Shift window/cursor focus to the left.  |
| `<Ctrl>j` | Shift window/cursor focus downwards.    |
| `<Ctrl>k` | Shift window/cursor focus upwards.      |
| `<Ctrl>l` | Shift window/cursor focus to the right. |
