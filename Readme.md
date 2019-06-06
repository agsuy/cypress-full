Run sample:

docker run --rm -v $PWD:/home/novnc/e2e/ -it -p 8080:8080 agsqa/my-cypress-full:latest

Launch super:
supervisord -c /home/novnc/supervisor/supervisord.conf &

Tag conv: agsqa/test-alpy:latest (test tag)

https://github.com/Zenika/alpine-chrome
