#!/bin/bash

set -e;

/usr/bin/supervisord -c /home/novnc/supervisor/supervisord.conf > output.log 2>&1 &
/bin/bash -c 'printf "\n\n\nCypress All in One\n\nURL: www.(hostIP):8080/vnc.html\nHeadless test run: yarn run cypress run --browser chrome\nInteractive test run: yarn run cypress open\nRemember to copy your tests!\n\n"'
/bin/bash
