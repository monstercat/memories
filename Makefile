
all:
	redo -j12

deploy: all
	rsync --exclude .git -lDarvz . memories.monstercat.com:monstercat/memories
