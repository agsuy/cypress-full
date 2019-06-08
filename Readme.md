# Run command:
hint: set this as an alias!

`((sleep 1 ; printf "\n\nLoading....... Hash:") && (sleep 3 ; docker exec -d testing bash /home/novnc/stream.sh ; printf "\nCypress All in One - Ikatu R&D\n\nURL: www.(hostIP):8080/vnc.html\nHint: yarn run cypress run --browser-chrome\n\n") &) && docker create --rm --name testing -it -p 8080:8080 agsqa/cypressmod:latest && docker cp cypress.json testing:/home/novnc && docker cp cypress/ testing:/home/novnc && docker start testing && docker attach testing`

Launch super (stream.sh):
supervisord -c /home/novnc/supervisor/supervisord.conf &

Tag conv: agsqa/cypressmod:latest (test tag)

https://github.com/Zenika/alpine-chrome
