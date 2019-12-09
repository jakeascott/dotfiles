# Make a new tmux session with: 
    `tmux new -s <session name>`

## To list existing sessions:
    `tmux ls`

To attach to an existing session:
    `tmux attach -t <session name>`

To kill a session
    `tmux kill-session -t <session name>`

Create a new window with:
    lead+c

Cycle between windows:

    * lead+n | next window
    * lead+p | prev window
    * lead+<num> | jump to window
    * lead+w | list windows
    * lead+f | find window
    * lead+, | rename active window
    * lead+q | jump to pane by number
    * lead+x | kill pane
    * lead+[ | activate scroll
    * lead+t | clock
    * lead+? | show keybinds
