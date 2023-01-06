$appname = (dir)[0].Parent
$appdir = '/tmp/'+$appname

docker run --rm -v ${pwd}:${appdir} --workdir ${appdir} maven:3-openjdk-11 ./mvnw clean install