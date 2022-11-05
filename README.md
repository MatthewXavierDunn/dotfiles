# My NeoVim Setup

My NeoVim setup for hitting the ground running. Simply clone this repository and
follow the setup steps.

## Prerequisites

 - [`neovim`](https://neovim.io/) for the actual text editor.
 - [`tmux`](https://github.com/tmux/tmux/wiki) for terminal multiplexing.
 - [`ripgrep`](https://github.com/BurntSushi/ripgrep) Rust based replacement
   for grep which is blazingly fast 🚀 (required for the `telescope` nvim
   plugin).

## Setup

1. Clone the repo.
2. Move the contents of the `nvim` folder into your nvim config folder: `~/.config/nvim`.
3. Move the `.tmux.conf` file in the `tmux` folder into your home directory:
   `~`.
4. Install the tmux plugin manager - tpm:
  ```bash
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ```
5. Run both tmux and nvim to perform the initial setup and installation of all
   specified plugins.
6. You will now have a pretty good neovim setup with tmux compatibility.

## Key Bindings

All `<leader>` tags represent the space key which I have set to be the leader
key for neovim.

### tmux Specific

| Key | Explanation |
|-----|-------------|
| `<Ctrl-a>r` | Refresh tmux config. |
| `<Ctrl-a>h` | Resize tmux pane leftwards. |
| `<Ctrl-a>j` | Resize tmux pane downwards. |
| `<Ctrl-a>k` | Resize tmux pane upwards. |
| `<Ctrl-a>l` | Resize tmux pane rightwards. |
| `<Ctrl-a>|` | Split tmux pane horizontally. |
| `<Ctrl-a>-` | Split tmux pane vertically. |

### neovim Specific

| Key | Explanation |
|-----|-------------|
| `<leader>nt` | Opens the file `nvim-tree` file explorer. |
| `<leader>ca` | See code actions. |
| `<leader>rn` | Rename symbol. |
| `<leader>d` | Show line diagnostics. |
| `[d` | jump to previous diagnostic. |
| `]d` | jump to next diagnostic. |
| `K` | Show documentation for symbol under cursor. |
| `<leader>nh` | Remove search highlight. |
| `<leader>ff` | Fuzzy find file in current directory. |
| `<leader>fs` | Fuzzy find string in current directory. |
| `<leader>fc` | Find string after cursor in current directory. |
| `<leader>fb` | List buffers. |
| `<leader>fh` | List help tags. |
| `<leader>+` | Increment number under cursor. |
| `<leader>-` | Decrement number under cursor. |
| `<leader>sv` | Split window horizontally. |
| `<leader>sh` | Split window vertically. |
| `<leader>se` | Make split windows equal size. |
| `<leader>sx` | Close current split window. |
| `<leader>to` | Open new tab. |
| `<leader>tx` | Close current tab. |
| `<leader>tn` | Go to next tab. |
| `<leader>tp` | Go to previous tab. |
| `<leader>sm` | Toggle split window maximisation. |
| `<Ctrl>b` | Scroll docs up. |
| `<Ctrl>f` | Scroll docs down. |
| `<Ctrl><Space>` | Show completion window. |
| `<Ctrl>e` | Close completion window. |
| `gf` | Show definition. |
| `gD` | Go to declaration. |
| `gd` | Preview definition. |
| `gi` | Go to implementation. |
| `<Ctrl>o` | See outline on right hand side. |

### Shared Key Bindings

The following movments are standardised across tmux, neovim, and any subwindows
in the neovim instance.

| Key | Explanation |
|-----|-------------|
| `<Ctrl>h` | Shift window/cursor focus to the left. |
| `<Ctrl>j` | Shift window/cursor focus downwards. |
| `<Ctrl>k` | Shift window/cursor focus upwards. |
| `<Ctrl>l` | Shift window/cursor focus to the right. |
