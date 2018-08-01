FROM redmine:latest

# Setting Mail of Redmine
RUN rm -rf /usr/src/redmine/config/configuration.yml.example \
  && ln -s /home/redmine/config/configuration.yml /usr/src/redmine/config/configuration.yml


#  && ln -s /home/redmine/config/configuration.yml /usr/src/redmine/config/configuration.yml \
#  && rm -rf /usr/src/redmine/config/database.yml \
#  && ln -s /home/redmine/config/database.yml /usr/src/redmine/config/database.yml

# ------------------------
# SSH Server support
# ------------------------
RUN apt-get update \
  && apt-get install -y --no-install-recommends openssh-server \
  && echo "root:Docker!" | chpasswd \
  && apt-get install -y --no-install-recommends vim

COPY sshd_config /etc/ssh/
EXPOSE 2222 587

COPY init_container.sh /bin/
RUN chmod 777 /bin/init_container.sh
CMD ["sh", "/bin/init_container.sh"]
