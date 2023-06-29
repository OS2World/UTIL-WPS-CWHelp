#/*
# * Copyright (c) Chris Wohlgemuth 2002 
# * All rights reserved.
# *
# * http://www.geocities.com/SiliconValley/Sector/5785/
# * http://www.os2world.com/cdwriting
# *
# * Redistribution and use in source and binary forms, with or without
# * modification, are permitted provided that the following conditions
# * are met:
# * 1. Redistributions of source code must retain the above copyright
# *    notice, this list of conditions and the following disclaimer.
# * 2. Redistributions in binary form must reproduce the above copyright
# *    notice, this list of conditions and the following disclaimer in the
# *    documentation and/or other materials provided with the distribution.
# * 3. The authors name may not be used to endorse or promote products
# *    derived from this software without specific prior written permission.
# *
# * THIS SOFTWARE IS PROVIDED ``AS IS'' AND
# * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# * ARE DISCLAIMED.  IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE
# * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# * SUCH DAMAGE.
# *
# */

# Use VAC++3.08 to compile

VERSION		=	0_1_0
DISTNAME	=	cwhelp-class-$(VERSION)
CC           = icc

LDFLAGS =	-Ge- /Gm+ -G4 /ss -Gl /O+ -Oc+ -Ol-  /Q+ 
CFLAGS       =   -Ge- /Gm+ -G4 /ss -Gl /O+ -Oc+ -Ol- /Q+ /C

LIBS		=	somtk.lib
DEFS		= 

OBJECTS	= cwhelp.obj

all: cwhelp.dll cwhelp.hlp

cwhelp.dll: cwhelp.ih  cwhelp.obj cwhelp.def
	$(CC) $(LDFLAGS) /L /Fm$(basename $@)  /Fe$@ $(OBJECTS) $(LIBS) cwhelp.def

cwhelp.ih:	cwhelp.idl
	sc -p -v -r -maddstar -mnoint -S128000 -C128000  $<
	sc -p -v -r -maddstar -mnoint -S128000 -C128000 -sc $<


cwhelp.obj:	cwhelp.c cwhelp.ih
	$(CC) -I $(MOREINC) -I $(MOREINC2) $(CFLAGS)  /Fo$@ $<

cwhelp.hlp:	cwhelp.ipf
	ipfc cwhelp.ipf

clean:
	-rm *.obj
	-rm *.map

cleaner:
	-rm *.*~
	-rm *.RES

german:

english:

distribution:
	make
	make clean
	make cleaner
	-cd ..\. && mkdir bin
	-cd ..\bin && rm *.dll *.hlp
	-cp *.hlp ..\bin
	-cp *.dll ..\bin
	-rm *.dll
	-rm *.hlp
	-cd ..\. && rm *.zip
	-cd ..\. && zip -r cwhelp-$(VERSION).zip *

