FROM node:alpine

RUN npm install -g tiddlywiki@5.2.3

ENV USER=user
ENV GRP=user
ENV UID=1001
ENV GID=1001
RUN addgroup -S pi
RUN adduser \
    --disabled-password \
    --gecos "" \
    --ingroup "$GRP" \
    --no-create-home \
    --uid "$UID" \
    "$USER"
RUN echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Setup wiki volume
VOLUME /var/lib/tiddlywiki
WORKDIR /var/lib/tiddlywiki

# Add init-and-run script
ADD init-and-run-wiki /usr/local/bin/init-and-run-wiki

RUN chown -R $UID:$GID /usr/local/bin/ &&\
    chown -R $UID:$GID  /var/lib/tiddlywiki

# Meta
USER $USER

CMD ["/usr/local/bin/init-and-run-wiki"]
