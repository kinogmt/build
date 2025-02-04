# CentOS build environment with ant and jdk8

docker-compose.yml in this directory can start a container
with ant and jdk8.
It's also mounting ~/work of your host machine.
So if you have your git working directory,
for example there in ~/work/ of your host machine,
you can run ant in /home/worker/work/<git-work-dir> on the container.

It's also mounting ~/.ssh of your host machine,
you can use ssh keys there on the host machine from the container.


## start container

```
docker-compose up -d bld
```

## ssh to container

```
ssh -p3022 -A worker@localhost
```

## build with ant(on the conatainer)
```
cd ~/work/<git-work-dir>
ant
```

## stop container

```
docker-compose stop
```

## remove container

```
docker-compose rm
```

## notes for macos
spotbugs-ant.jar is not correctly recognized on macos.

workaround:

After starting the container -
```
sudo rm $JAVA_HOME/ant/lib/spotbugs-ant.jar
sudo ln -s /usr/local/spotbugs/lib/spotbugs-ant.jar $JAVA_HOME/ant/lib/spotbugs-ant.jar
```
 or
```
sudo rm /usr/local/apache-ant-<version>/lib/spotbugs-ant.jar
sudo ln -s /usr/local/spotbugs/lib/spotbugs-ant.jar /usr/local/apache-ant-<version>/lib/spotbugs-ant.jar
```
