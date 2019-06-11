#!/bin/bash

set -e;

/usr/bin/supervisord -c /home/novnc/supervisor/supervisord.conf > output.log 2>&1 &
/bin/bash -c 'printf "\n\n\nCypress All in One\n\nURL: www.(hostIP):8080/vnc.html\nHint: yarn run cypress run --browser chrome\n\n"'
/bin/bash
