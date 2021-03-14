#!/bin/sh

git add . \
&& git commit -m "update configs $(date +%Y-%m-%d)" \
&& git push
