FROM aegypius/confd

# Installing required packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends nginx curl

# configuring default nginx
RUN /etc/nginx/sites-enabled/default
ADD add/nginx.conf /etc/nginx/nginx.conf

# Clean packages 
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

# making confd directories
RUN mkdir -p /etc/confd/{templates, conf.d}

VOLUME /etc/confd/

ADD add/conf/ /etc/confd/conf.d/
ADD add/template/ /etc/confd/templates/


CMD ["confd"]
