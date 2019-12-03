#!/bin/bash
flex cms.l
bison -d cms.y
gcc -w -c *.c
gcc -w -o cms *.o -ly -lfl