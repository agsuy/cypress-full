#!/bin/bash

set -ex;

/usr/bin/supervisord -c /home/novnc/supervisor/supervisord.conf > output.log 2>&1 &
/bin/bash
