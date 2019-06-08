Run sample:

docker create --rm --name testing -it -p 8080:8080 agsqa/cypressmod:latest && docker cp . testing:/home/novnc && docker start testing && docker attach testing

Launch super:
supervisord -c /home/novnc/supervisor/supervisord.conf &

Tag conv: agsqa/cypressmod:latest (test tag)

https://github.com/Zenika/alpine-chrome
