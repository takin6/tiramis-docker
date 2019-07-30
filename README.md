# tiramis-docker #


## Premise
- Install Git  
Refer to "Homebrewとは" in this article  
https://tracpath.com/bootcamp/git-install-to-mac.html  

- Install Ruby 2.6.3 by rbenv  
**Don't forget to change ruby version to 2.6.3  
https://qiita.com/seiyatakahashi/items/1447c401c928d08a040b  

- Install Docker for Mac  
https://docs.docker.com/docker-for-mac/  

## Compose Environment
Run Commands
```
$ git clone git@github.com:takin6/tiramis-docker.git
$ cd tiramis-docker
$ git clone git@github.com:takin6/tiramis.git
$ bundle install --path vendor/bundle
$ brew install unison
$ brew install eugenmayer/dockersync/unox
$ docker network create tabi-network

$ bundle exec docker-sync-stack start
``` 


## Docker Commands
```
$ docker-compose exec web bash #start bash process of web container
$ docker container 
```

## When Something Went Wrong  
1. Stop Containers
```
$ docker-compose down
```
