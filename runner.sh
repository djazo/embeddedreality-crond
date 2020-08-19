#!/bin/sh

# get our periodic from directory name

_identify="$(basename $(dirname $0))"

# fetching containers
case $_identify in
    15min|hourly|daily|weekly|monthly)
        _crons=$(docker ps --filter "label=com.embeddedreality.cron.${_identify}" --format "{{.ID}}!{{.Label \"com.embeddedreality.cron.${_identify}\"}}")
        ;;
    *)
        echo "I don't know how what to do... sorry."
        exit 1
        ;;
esac

for c in $_crons; do
    _container="$(echo $c | cut -d'!' -f1)"
    _command="$(echo $c | cut -d'!' -f2)"
    echo "Running ${_command} in ${_container}"
    docker exec -t ${_container} /bin/sh -c "${_command}"
done
