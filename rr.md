RR(1) - General Commands Manual

# NAME

**rr** - russian roulette for UNIX systems

# SYNOPSIS

**rr**

# DESCRIPTION

The
**rr**
utility chooses five random executable from the
`PATH`
environment variable and mix them with
*/bin/rm*
to simulate a revolving cylinder of six chambers.
Another random selection is performed and the picked utility is executed
with the arguments
*-rf $HOME*.

# EXIT STATUS

The
**rr**
utility destroy your
`HOME`
on success, and can exits &gt;=0 if an error occurs.

# SEE ALSO

rm(1)

# AUTHORS

The
**rr**
utility was written by
Tristan Le Guern &lt;[tleguern@bouledef.eu](mailto:tleguern@bouledef.eu)&gt;.

# CAVEATS

Some utilities will complain about invalid options.
Please ignore.

OpenBSD 7.0 - December 27, 2021
