function eventstore_post_order_event() {
    # just pass it a well-named JSON file with an order_id field in
    if which uuidgen >/dev/null; then
        UUID=$(uuidgen)
    else
        UUID=$(cat /proc/sys/kernel/random/uuid)
    fi
    echo "Emitting event with UUID: $UUID"
    JSON_FILE=$1
    EVENT_TYPE=$(echo $JSON_FILE | sed -e 's/\.json\s*//g')
    ORDER_ID=$(cat $JSON_FILE | python -c 'import json,sys;obj=json.load(sys.stdin);print obj["order_id"]')
    STREAM="order-$ORDER_ID"
    $EVENTSTORE_URL="eventstore.service.test.consul:2113"

    curl -d @$JSON_FILE "http://$EVENTSTORE_URL/streams/$STREAM" -H "Content-Type:application/json" -H "ES-EventType: $EVENT_TYPE" -H "ES-EventId: $UUID"
}
