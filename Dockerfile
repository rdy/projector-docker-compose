FROM registry.jetbrains.team/p/prj/containers/projector-idea-u
USER root
RUN true \
  && apt-get update \
  && apt-get install curl -yq \
  && curl -sL https://deb.nodesource.com/setup_10.x  | bash - \
  && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update \
  && apt-get install gnupg wget zsh nodejs yarn -yq \
  && sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.1/zsh-in-docker.sh)" -- \
  -t minimal \
  -p git \
  -p node \
  && npm install -g purer-prompt --allow-root --unsafe-perm=true \
# clean apt to reduce image size:
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /var/cache/apt    
ENV PROJECTOR_USER_NAME projector-user
USER $PROJECTOR_USER_NAME
EXPOSE 8887
CMD ["bash", "-c", "/run.sh"]