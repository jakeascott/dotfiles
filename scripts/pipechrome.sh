#!/bin/bash
# Opens chrome with an html file from stdin
chrome "data:text/html;base64,$(base64 -w 0 <&0)"
