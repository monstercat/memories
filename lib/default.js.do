TARG=../src/$2
redo-ifchange $TARG.coffee
coffee -cs < $TARG.coffee > $3


