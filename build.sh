#!/bin/sh

#npm install yo
#npm install coffee-script
#npm install coffee-script-redux
#npm install karma
#npm install generator-angular
#npm install phantomjs
#sudo npm install -g PhantomJS
#npm install karma-phantomjs-launcher --save-dev

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

function local_https_server {
    JAVA_OPTS=-Dhttps.port=9001 play run
}

function deploy_prod {
    now=$(date +"%s")
    srcFilename="$(pwd)/target/universal/kulebao-1.0-SNAPSHOT.zip"
    destFilename="kulebao-1.0-SNAPSHOT.$now.zip"
    destServer="kulebao@115.28.7.205"
    destPath="$destServer:~/$destFilename"
    play dist && \
    scp $srcFilename $destPath && \
    ssh $destServer "unzip -x $destFilename -d /var/play/$now/" && \
    ssh $destServer "rm /var/play/kulebao" && \
    ssh $destServer "ln -s /var/play/$now/kulebao-1.0-SNAPSHOT/ /var/play/kulebao" && \
    ssh $destServer "echo coco999 | sudo -S service kulebao restart"

    retvalue=$?
    echo "Return value: $retvalue"
    echo "Done"
}


function main {
  	case $1 in
		s) local_https_server ;;
		a) all ;;
		d) deploy ;;
		prod) deploy_prod ;;
		p) build_and_push ;;
		b) build_local ;;
		*) build_local ;;
	esac
}

main $@
