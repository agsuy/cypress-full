FROM agsqa/my-cypress-chrome

# Install git, supervisor, VNC, X11 as well as ca, https and gnupg2 packages
RUN apt-get update; \
    apt-get install -y --no-install-recommends \
      bash \
      fluxbox \
      net-tools \
      socat \
      supervisor \
      x11vnc \
      xterm && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Add user

RUN adduser --disabled-password --gecos '' novnc

RUN adduser novnc sudo

RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN mkdir -p /home/novnc/supervisor/logs
RUN mkdir -p /home/novnc/supervisor/pid


RUN git clone https://github.com/kanaka/noVNC.git /home/novnc/repo-noVNC \
	&& git clone https://github.com/kanaka/websockify /home/novnc/repo-noVNC/utils/websockify \
	&& rm -rf /home/novnc/repo-noVNC/.git \
	&& rm -rf /home/novnc/repo-noVNC/utils/websockify/.git \
        && rm -rf /usr/local/bin/docker-entrypoint.sh

RUN chown -R novnc:novnc /home/

# Setup demo environment variables
ENV HOME=/home/novnc \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=1920 \
    DISPLAY_HEIGHT=1080 \
    RUN_XTERM=yes \
    RUN_FLUXBOX=yes

# Copy supervisor configuration
COPY . /home/novnc/supervisor/

# Show port for novnc
EXPOSE 8080

# Set session
USER novnc:novnc
ENTRYPOINT ["/bin/bash"]
WORKDIR /home/novnc

