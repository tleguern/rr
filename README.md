# rr - Russian Roulette

The rr utility chooses five random executable from your $PATH and mix them
with /bin/rm to simulate a revolving cylinder of six chambers. Another
random selection is performed and the picked utility is executed with the
arguments `-rf $HOME`. Beware that some of the utilities will complains
about “invalid options”.

This script was implemented after a pun I read somewhere. This page will
be updated if I ever found it the source again.

The random selection is performed using either jot(1), shuf(1) or a
terrible internal system.
