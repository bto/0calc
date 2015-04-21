#!/bin/sh
touch AUTHORS COPYING ChangeLog NEWS README

aclocal
autoheader
automake --add-missing
autoconf
