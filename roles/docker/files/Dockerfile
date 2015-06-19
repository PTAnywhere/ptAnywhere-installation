FROM    ubuntu:14.10

# Sources:
#  - http://www.nuxeo.com/blog/docker-containers-nuxeo-part-2-add-vnc-openbox/
#  - http://stackoverflow.com/questions/16296753/can-you-run-gui-apps-in-a-docker-container/16311264#16311264


# make sure the package repository is up to date
RUN     echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN     apt-get update


# Install vnc, xvfb in order to create a 'fake' display and firefox
RUN     apt-get install -y x11vnc xvfb firefox supervisor
RUN     mkdir ~/.vnc
# Setup a password
RUN     x11vnc -storepasswd 1234 ~/.vnc/passwd


# Copy and run the program which starts VNC and firefox on it
COPY startXvfb.sh startXvfb.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf


EXPOSE 5900


#ENTRYPOINT
CMD ["/usr/bin/supervisord"]
