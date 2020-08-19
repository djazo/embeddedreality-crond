FROM alpine:3.12.0

RUN apk add --no-cache docker-cli

# copying scripts

COPY entrypoint.sh /entrypoint.sh
COPY runner.sh /usr/local/bin/runner.sh

# setup scripts
# remember that run-parts that is run on cron doesn't support . in filenames, so no .sh etc in those. hence, plain runner

RUN chmod 755 /entrypoint.sh ; \
    chmod 700 /usr/local/bin/runner.sh ; \
    for d in 15min hourly daily weekly monthly ; do ln -s /usr/local/bin/runner.sh /etc/periodic/$d/runner ; done

ENTRYPOINT [ "/entrypoint.sh" ]

# rather fake cmd here
CMD [ "-d" ]

LABEL com.embeddedreality.image.maintainer="arto.kitula@gmail.com" \
        com.embeddedreality.image.title="crond" \
        com.embeddedreality.image.version="1" \
        com.embeddedreality.image.description="Cron daemon for Docker stack"
