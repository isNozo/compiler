#!/bin/sh

../sim < $1 > $1.S && gcc $1.S && ./a.out ;
rm -rf $1.S a.out
