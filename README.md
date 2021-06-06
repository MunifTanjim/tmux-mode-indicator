# Tmux Mode Indicator

Plugin that displays prompt indicating currently active Tmux mode.

**Prefix Prompt**:  
![Prefix Prompt](screenshots/prefix.png)

**Copy Prompt**:  
![Copy Prompt](screenshots/copy.png)

**Sync Prompt**:  
![Sync Prompt](screenshots/sync.png)

**Empty Prompt**:  
![Empty Prompt](screenshots/empty.png)

_Note: This is a trimmed down version of the original [tmux-prefix-highlight](https://github.com/tmux-plugins/tmux-prefix-highlight) plugin._

## Usage

Add `#{tmux_mode_indicator}` to the `status-left` or `status-right` option of Tmux. For example:

```conf
set -g status-right '%Y-%m-%d %H:%M #{tmux_mode_indicator}'
```

## Installation

### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)

Add this repository as a TPM plugin in your `.tmux.conf` file:

```conf
set -g @plugin 'MunifTanjim/tmux-mode-indicator'
```

Press `prefix + I` in Tmux environment to install it.

### Manual Installation

Clone this repository:

```bash
git clone https://github.com/MunifTanjim/tmux-mode-indicator.git ~/.tmux/plugins/tmux-mode-indicator
```

Add this line in your `.tmux.conf` file:

```conf
run-shell ~/.tmux/plugins/tmux-mode-indicator/mode_indicator.tmux
```

Reload Tmux configuration file with:

```sh
tmux source-file ~/.tmux.conf
```

## Configuration Options

The following configuration options are available:

```ini
# prompt to display when tmux prefix key is pressed
set -g @mode_indicator_prefix_prompt ' WAIT '

# prompt to display when tmux is in copy mode
set -g @mode_indicator_copy_prompt ' COPY '

# prompt to display when tmux has synchronized panes
set -g @mode_indicator_sync_prompt ' SYNC '

# prompt to display when tmux is in normal mode
set -g @mode_indicator_empty_prompt ' TMUX '

# style values for prefix prompt
set -g @mode_indicator_prefix_mode_style 'bg=blue,fg=black'

# style values for copy prompt
set -g @mode_indicator_copy_mode_style 'bg=yellow,fg=black'

# style values for sync prompt
set -g @mode_indicator_sync_mode_style 'bg=red,fg=black'

# style values for empty prompt
set -g @mode_indicator_empty_mode_style 'bg=cyan,fg=black'
```

### Custom Indicator

You can override the indicator at any time by setting these options:

```ini
# prompt to display instead of default mode indicators
set @mode_indicator_custom_prompt ' ---- '

# style values for custom prompt
set @mode_indicator_custom_mode_style 'default'
```

To revert back to the default mode indicators, unset those options:

```ini
set -u @mode_indicator_custom_prompt

set -u @mode_indicator_custom_mode_style
```

## License

Licensed under the MIT License. Check the [LICENSE](./LICENSE) file for details.
