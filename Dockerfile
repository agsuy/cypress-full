FROM bitnami/node:12-debian-9

# Install Cypress dependencies
RUN apt-get update && \
  apt-get install --no-install-recommends -qqy \
  libgtk-3-0 \
  libnotify-dev \
  libgconf-2-4 \
  libnss3 \
  libxss1 \
  libasound2 \
  libxtst6 \
  xauth \
  xvfb \
  && rm -rf /var/lib/apt/lists/*

# Install chrome-stable
RUN apt-get update && \
  apt-get install --no-install-recommends -qqy \
  apt-transport-https \
  gnupg2

RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update -qqy \
  && apt-get -qqy install google-chrome-stable \
  && rm /etc/apt/sources.list.d/google-chrome.list \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Install bash, supervisor, VNC, X11  packages
RUN apt-get update; \
    apt-get install -y --no-install-recommends \
      bash \
      fluxbox \
      net-tools \
      socat \
      supervisor \
      x11vnc \
      && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Add user
RUN adduser --disabled-password --gecos '' novnc \
    && adduser novnc sudo \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && mkdir -p /home/novnc/supervisor/logs \
    && mkdir -p /home/novnc/supervisor/pid 


# novnc
RUN git clone https://github.com/novnc/noVNC.git /home/novnc/delrepo-noVNC \
	&& git clone https://github.com/novnc/websockify /home/novnc/delrepo-noVNC/utils/websockify \
	&& apt-get purge -qqy git \ 
        apt-transport-https \
        gnupg2 \
        && mkdir -p /home/novnc/repo-noVNC/utils/websockify \
        && cp -ar /home/novnc/delrepo-noVNC/utils/websockify/websockify /home/novnc/repo-noVNC/utils/websockify \
        && cp -ar /home/novnc/delrepo-noVNC/utils/websockify/include /home/novnc/repo-noVNC/utils/websockify \
        && cp -ar /home/novnc/delrepo-noVNC/utils/websockify/run /home/novnc/repo-noVNC/utils/websockify \
        && cp -ar /home/novnc/delrepo-noVNC/utils/websockify/websockify.py /home/novnc/repo-noVNC/utils/websockify \
        && cp -ar /home/novnc/delrepo-noVNC/utils/launch.sh /home/novnc/repo-noVNC/utils \
        && cp -ar /home/novnc/delrepo-noVNC/core /home/novnc/repo-noVNC \
        && cp -ar /home/novnc/delrepo-noVNC/vendor /home/novnc/repo-noVNC \
        && cp -ar /home/novnc/delrepo-noVNC/app /home/novnc/repo-noVNC \
        && cp -ar /home/novnc/delrepo-noVNC/vnc.html /home/novnc/repo-noVNC \
        && cp -ar /home/novnc/delrepo-noVNC/vnc_lite.html /home/novnc/repo-noVNC \
        && rm -rf /home/novnc/delrepo-noVNC \
        && rm -rf /usr/local/bin/docker-entrypoint.sh

RUN chown -R novnc:novnc /home/

# Setup environment variables
ENV HOME=/home/novnc \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=1366 \
    DISPLAY_HEIGHT=768 \
    PORT=8080 \
    RUN_FLUXBOX=yes

# Copy supervisor configuration
COPY conf.d /home/novnc/supervisor/conf.d/
COPY supervisord.conf /home/novnc/supervisor/
COPY stream.sh /usr/local/bin

# Set streaming to easy command
RUN cd /usr/local/bin && chmod 755 stream.sh

# Show port for novnc
EXPOSE $PORT

# Set session
USER novnc:novnc
WORKDIR /home/novnc
RUN yarn add cypress --dev
ENTRYPOINT ["stream.sh"]
