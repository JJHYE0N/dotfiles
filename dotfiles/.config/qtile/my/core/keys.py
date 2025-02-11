from typing import List

from libqtile.config import Group, Key
from libqtile.lazy import lazy


def create_keys(mod: str, terminal: str, groups: List[Group]):
    keys = [
        # A list of available commands that can be bound to keys can be found
        # at https://docs.qtile.org/en/latest/manual/config/lazy.html
        # Basic Commands
        Key([mod], "r", lazy.spawn("rofi -show drun"), desc="Spawn a command using a prompt widget"),
        Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
        Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
        Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
        Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
        Key([mod], "space", lazy.next_layout(), desc="Toggle between layouts"),
        Key([mod], "Tab", lazy.layout.next(), desc="Move window focus to other window"),
        # Switch between windows
        Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
        Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
        Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
        Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
        # Move windows between left/right columns or move up/down in current stack.
        # Moving out of range in Columns layout will create new column.
        Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
        Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
        Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
        Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
        # Grow windows. If current window is on the edge of screen and direction
        # will be to screen edge - window would shrink.
        Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
        Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
        Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
        Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
        Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
        # Toggle between split and unsplit sides of stack.
        # Split = all windows displayed
        # Unsplit = 1 window displayed, like Max layout, but still with
        # multiple stack panes
        Key(
            [mod, "shift"],
            "Return",
            lazy.layout.toggle_split(),
            desc="Toggle between split and unsplit sides of stack",
        ),
        Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    ]
    for group in groups:
        keys.extend(
            [
                # mod1 + letter of group = switch to group
                Key(
                    [mod],
                    group.name,
                    lazy.group[group.name].toscreen(),
                    desc=f"Switch to group {group.name}",
                ),
                # mod1 + shift + letter of group = switch to & move focused window to group
                Key(
                    [mod, "control"],
                    group.name,
                    lazy.window.togroup(group.name, switch_group=True),
                    desc=f"Switch to & move focused window to group {group.name}",
                )
                # Or, use below if you prefer not to switch to that group.
                # # mod1 + shift + letter of group = move focused window to group
                # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
                #     desc="move focused window to group {}".format(i.name)),
            ]
        )

    return keys
