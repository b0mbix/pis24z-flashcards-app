FROM sonatype/nexus3:latest

COPY --chown=nexus:nexus ./scripts/initialize_nexus.groovy /opt/sonatype/nexus/nexus-data/etc/scripts/init.groovy

COPY --chown=nexus:nexus ./scripts/init_script.sh /opt/sonatype/nexus/init_script.sh
RUN chmod +x /opt/sonatype/nexus/init_script.sh

# CMD ["/bin/bash", "-c", "/opt/sonatype/nexus/bin/nexus run & /opt/sonatype/nexus/init_script.sh"]





