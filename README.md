# DOCKER APACHE DAN PHP 7.0

## PENGGUNAAN

### Clone

```bash
$ git clone http://github.com/derymukti/dockerphp70apache.git 
```

### Open
```bash
$ cd dockerphp70apache
```
Anda dapat mengubah file di dalam folder www atau mengganti dengan program anda

## BUILD DOCKER CONTAINER AN RUN STATIC


### Build
```bash
$ sudo docker build -t mysite . 
```

### Run
```bash
$ sudo docker run -d --name mysite-container -p 8080:80 mysite 
```
buka http://localhost:8080

### Stop
```bash
$ sudo docker stop mysite-container
```

## CONFIG & RUN WITH DOCKER-COMPOSE (opsi 1)

### Config
file docker-compose.yml
```json
version: '2'
services:
  app:
	  image: derymukti/php70:latest
	  volumes: 
	   - ./www:/var/www/html:rw
	  ports:
	   - "8080:80"
```
Anda dapat mengganti image dengan 'mysite'.

atau anda dapat merubah file docker-compose.yml menjadi
```json
version: '2'
services:
  app:
	  build: ./
	  volumes: 
	   - ./www:/var/www/html:rw
	  ports:
	   - "8080:80"
```


### Start & Build
```bash
$ sudo docker-compose up --build
```

### Start Only
```bash
$ sudo docker-compose up -d
```

### Stop
```bash
$ sudo docker-compose down
```

## RUN DYNAMIC WITH DOCKER (opsi 2)


### Run Dynamic Volume
```bash
$ sudo docker run -d --name mysite-container -v /home/$(whoami)/dockerphp70apache/www:/var/www/html -p 8080:80 mysite
```

### Stop
```bash
$ sudo docker stop mysite-container
```