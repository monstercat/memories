#!/bin/bash
DEPS=$(find ./routes -name "*.js" | paste -s -d, -)
DEPS+=",app.js"
supervisor -w $DEPS app.js
