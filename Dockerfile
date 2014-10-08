FROM aegypius/confd

# Installing required packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends nginx curl

# Clean packages 
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

# configuring default nginx
RUN /etc/nginx/sites-enabled/default
ADD add/nginx.conf /etc/nginx/nginx.conf

# adding confd_watch
ADD add/confd_watch /usr/local/bin/confd_watch
RUN chmod +rx /usr/local/bin/confd_watch

# making confd directories
RUN mkdir -p /etc/confd/{templates, conf.d}
ADD add/conf/ /etc/confd/conf.d/
ADD add/template/ /etc/confd/templates/

VOLUME /etc/confd/

CMD ["/usr/local/bin/confd_watch"]
