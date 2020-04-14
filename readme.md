# DataDog Send Alert Bash Function

Simple Bash function to send alerts to DataDog. This assumes that you have already installed the [datadog-agent](https://docs.datadoghq.com/getting_started/agent/) on the localhost and it is listening on the default UDP port 8125.

## Basic usage:

```shell
#!/bin/bash
source datadog_send_alert.sh

send_dd_alert "alert title" "alert body text"
```



## Advanced usage:

```shell
#!/bin/bash
source datadog_send_alert.sh

# Environment variables
host='127.0.0.1'
port='8125'

# Define message vars
body="Alert message body"
tags="script_name"
group="$(date +%s)" # Unique string to group related alerts

# Send Grouped Alerts
send_dd_alert "Script starting" "$body" "info" "$group" "$tags"
send_dd_alert "Successfully did a thing" "$body" "success" "$group" "$tags"
send_dd_alert "Noticed something" "$body" "info" "$group" "$tags"
send_dd_alert "Hmmm, this doesn't seem right" "$body" "warning" "$group" "$tags"
send_dd_alert "Oh snap! An error!" "$body" "error" "$group" "$tags"
```



### Detailed API documentation:

https://docs.datadoghq.com/developers/dogstatsd/datagram_shell/?tab=events