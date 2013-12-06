#!/bin/sh

#npm install coffee-script
#npm install coffee-script-redux
#npm install karma
#npm install generator-angular


#!/bin/sh

function build_local {
    karma start --single-run && \
    play test
}

function build_and_push {
    git pull --rebase && \
    build_local && \
    git push origin master
}

function deploy {
    build_local && \
    git push heroku master
}

function all {
    build_local && \
    git push origin master && \
    git push heroku master
}

function main {
  	case $1 in
		a) all ;;
		d) deploy ;;
		p) build_and_push ;;
		b) build_local ;;
		*) build_local ;;
	esac
}

main $@