FROM ditaot/dita-ot-base
MAINTAINER Me Myself "me@example.com"
#
# My custom DITA Open Toolkit
#
WORKDIR ${DITA_HOME}
ENV DITA_COMM_URL=https://github.com/dita-community/ BRANCH=develop
#
# Get plugin from DITA Community project:
RUN wget ${DITA_COMM_URL}org.dita-community.common.xslt/archive/${BRANCH}.zip && \
  unzip ${BRANCH}.zip -d plugins && 
  rm ${BRANCH}.zip
#
# Integrate new plugins
#
RUN ant -f integrator.xml
#
VOLUME /opt/dita-ot/DITA-OT
CMD /bin/bash
#
# End of Dockerfile
#