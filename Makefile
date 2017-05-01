
all: build

build:
	swipl -q -g main -o flp17-log -c flp17-log.pl

run: build
	./flp17-log

dev: build
	./flp17-log < ./tests/1.txt

it:
	swipl -q -o glp17-log -c flp17-log.pl && ./flp17-log
