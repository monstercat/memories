#!/bin/bash
DB=memories
MODEL=Code
IMPORT=${1:-codes.csv}
read -p "Execute db.$MODEL.remove() (y/n)? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
  echo ""
  echo "Removing memory models..."
  mongo $DB --eval "db.$MODEL.remove()"
else
  echo ""
  echo "OK, Not removing models"
fi
echo ""
echo "importing $IMPORT..."
mongoimport -d $DB -c $MODEL -fcode -type csv < $IMPORT
