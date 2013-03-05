#!/bin/bash
DEPS=$(find ./{routes,lib} -name "*.js" | paste -s -d, -)
DEPS+=",app.js"
supervisor -w $DEPS app.js
