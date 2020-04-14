# DataDog Events Reference:
# https://docs.datadoghq.com/developers/dogstatsd/datagram_shell/?tab=events

# Usage Documentation
:<<copy_this_code
#!/bin/bash
source /path/to/this/script.sh

# Simple example:
send_dd_alert "alert title" "alert body text"

# Advanced example:
send_dd_alert "alert title" "alert body text" "error" "unique-string-to-group-alerts" "my-app-tag"
copy_this_code

# Function Inputs:
#   Alert Title - required
#   Alert Body  - required
#   Alert type  - not required. Options are: error, warning, info, success (Default: Info)
#   Alert Group - not required. Unique string to group related alerts
#   Tags        - not required. Formats: tag1,tag2,etc  OR  tag1_name:tag1_value,tag2_name:tag2_value,etc
send_dd_alert() {
    # debug=1
    test -z "$1" && echo "Missing required: Title" && exit 1 || title="$1"
    test -z "$2" && echo "Missing required: Message Body" && exit 1 || body="$2"
    test -z "$3" || type="$3"
    test -z "$4" || group="$4"
    test -z "$5" || tags="$5"
    test -z "$host" || host="127.0.0.1"
    test -z "$port" || port="8125"

    message="_e{${#title},${#body}}:$title|$body|t:$type|k:$group|#$tags"
    test -z "$debug" || echo $message
    echo "$message" | nc -4u -w1 $host $port
}
