FROM aegypius/confd

# Installing required packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends nginx curl

# Clean packages 
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

VOLUME /etc/confd/


CMD ["confd"]
