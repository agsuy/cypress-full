


# Cypress all in one

TODO: 
- Improve docs (this)
- Fix window manager
- Add licence file and credit

## Intro:

stub

## Commands:

### Build: (tag may change)
`docker build -t agsqa/cypressmod:latest .`

### Run: (tag may change)
`docker run --rm -it -p 8080:8080 agsqa/cypressmod:latest`

#### Launch super (stream.sh):
supervisord -c /home/novnc/supervisor/supervisord.conf

STUFF:

Copy tests:

    First go to your cypress tests folder of choice

With docker already running (on another terminal) docker cp . $USER-testing:/home/novnc

Tag conv: agsqa/cypressmod:latest (test tag)

https://github.com/Zenika/alpine-chrome
