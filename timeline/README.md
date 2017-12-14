# Timeline Engine

This is an engine for managing states of some of my games. The engine is
designed initially for the Christmas game I made in December of 2017.

The two core (initial) requirements this engine needs are:
- managing triggers and transitions for state switching.
- timer functionality for transitioning to different states.

For ease of use, the timer functionality is measured in seconds.
Also, by default, the states wrap. So if you finish the last state, you are
brought back to the first state. If you don't want this functionality, then you
should make it so the last state has no way to change state.

-- Alan Morgan
