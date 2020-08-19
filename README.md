# Cron service

Cron service for running maitenance scripts inside Docker system

Start container with:

```sh
# docker run --mount type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock embeddedreality/cron
```

CROND_LOGLEVEL environment variable sets the loglevel for you, STDERR is used.

That's all for that one.

For every container you want to have cronned, you add label com.embeddedreality.cron.interval where interval is
15min, hourly, daily, weekly or monthly

For example if you want daily maitenance run:

```sh
# docker run -d --label com.embeddedreality.cron.daily=/usr/local/bin/daily.sh yourservice
```
