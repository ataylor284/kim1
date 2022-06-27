SUPERMON KIM based on JIM BUTTERFIELD's SUPERMON+ 64
====================================================

Adapted from J.B. Langston's reformatted and annotated SUPERMON+ 64
source.
 
SUPERMON+ 64 was one of the most powerful and popular machine language
monitors for the Commodore 64.  It evolved out of monitors for older
Commodore machines such as the the PET and possibly even the KIM-1
itself.  I've taken that source and ported it back to the KIM once
more.

Some features of the original are particularly suited to the C64 full
screen editor and line buffered input, and don't work quite as well
with a serial console.  Even so, the monitor is much more useful than
the primitive built-in KIM monitor.

A few of the notable changes to adapt to the KIM-1:

* "L"oad calls the KIM monitor LOAD routine to load a paper tape file;
  that routine is hardcoded to jump back to the KIM monitor on
  completion, so leaves you back in the KIM monitor
* "S"ave, and "V"erify are left unimplemented
* The loader installs the monitor as both the IRQ and NMI handler, so
  both the "ST"op button and a BRK trigger SUPERMON
* The e"X"it command returns to the built-in KIM monitor instead of
  BASIC
* The input routine handles ^H as backspace and lower case letters are
  converted to upper case
