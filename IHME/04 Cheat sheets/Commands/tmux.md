`tmux`: start a new window

# KEYSTROKES
- `Ctrl+B`: get tmux's attention
    -`X`: exit
    -`C`: open new window in current session
    -`N`: next window
    -`P`: previous window
    -`0` to `9`: Display window numbered 0 to 9
    -`W`: list windows
    -`D`: detach a session (will continue running in background)
    -`S`: list tmux sessions (must be in a session to do this of course)
    -`"`: split window horizontally
    -`%`: split current pane vertically
    -`x`: kill pane
    -`$`: rename a session
    -`,`: rename window

# COMMANDS
- `new`: new session
- `attach-session`
- `ls`: list sessions

# FLAGS
- `-s <name>`: give session a <name>
- `-t <name>`: target session with <name>

# EXAMPLES
- `tmux new -s singR`: open a new session named "singR"
- `tmux attach-session -t singR`: attach to the "singR" session
