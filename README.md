# rr - Russian Roulette

The rr utility chooses a random binary from your $PATH and tries to execute it with the arguments “-rf $HOME”. Beware that some of the selected utilities will complains about “invalid options”.

This script was implemented after a pun I read somewhere. I will update this page if I find the source again.

## Dependencies

The find(1), mktemp(1) and jot(1) utilities must be installed and available in your $PATH.
