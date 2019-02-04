FROM java:latest

MAINTAINER Jason Davis "jason.davis@cloudera.com"

ENV OT_VERSION 2.5.1
LABEL Cloudera DITA-OT config: ${OT_VERSION}
ENV CATALOG_DIR /opt/dita-ot/catalogs

# Make directories for later use
RUN mkdir -p /opt/dita-ot/catalogs
RUN chmod -R a+rwx /opt
RUN useradd -u 5555 -ms /bin/bash dita-ot

ENV HOME /home/dita-ot
ENV DITA_HOME $HOME/DITA-OT

# For OT 2.x the ant script is in the top-level bin/ dir
ENV ANT_HOME $DITA_HOME
ENV PATH $ANT_HOME/bin:$DITA_HOME:$PATH
USER 5555
WORKDIR $HOME
RUN wget -c https://github.com/hortonworks/dita-tools/blob/master/dita-ot/dita-ot.zip

# For doing lots of builds to avoid fetching each time.
RUN unzip dita-ot.zip && \
    rm dita-ot.zip

# Use a consistent name for the OT so we don't have to worry about it
RUN mv dita-ot DITA-OT

# Set execution permissions on ant/bin directory
RUN chmod a+rwx $DITA_HOME/bin/* 

# Put the bin directory in the path:
ENV PATH $HOME/DITA-OT/bin:$PATH
WORKDIR $DITA_HOME

# Prepare the /opt/dita-ot/DITA-OT directory
# so it can be used as a volume:
RUN ln -s $DITA_HOME /opt/dita-ot/DITA-OT

# Declare volumes intended to be mount points for
# host directories:
VOLUME /opt/dita-ot/data
VOLUME /opt/dita-ot/out

#
# NOTE For OT 2.x, the dita command manages the Java classpath.
#
# End of Dockerfile
