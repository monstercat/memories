redo-always

DEPS=$(find ../src -name '*.coffee' | sort)

echo $DEPS | redo-stamp

ls $DEPS | \
  sed 's/..\/src\///g' | \
  sed 's/coffee/js/g' | \
  xargs redo-ifchange
