#!/bin/bash
# Google search - Web Answers script
# Return the main entry 'Featured Snippets' if available

# Grab the query  
query="$1"

# Prepare request 
request="https://www.google.fr/search?"
request+="safe=active"
request+="&q=$(uriencode "$query")"
request+="&hl=$jv_pg_wa_lang"
#jv_debug "Request : $request"

# Run the request
searchResult=$(curl -s "$request" -H 'Pragma: no-cache' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'Cache-Control: no-cache' -H 'Connection: keep-alive' --compressed)
#jv_debug "Result : $searchResult"

# Extract the answer
answer=$(echo $searchResult | $jv_pg_wa_pup_parser '._XWk text{}')
#jv_debug "Answer : $answer"

# Return the answer
if [[ ! -z "$answer" ]]
then
    echo $answer "$(pg_web_answers_lang wa_source "Google")"
else
    echo ""
fi
