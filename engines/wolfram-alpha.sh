#!/bin/bash
# Wolfram|Alpha - Web Answers script

# Grab the query  
query="$1"

# Wolfram supports english only => translate if not english
if [[ "$jv_pg_wa_lang" != "en" ]]
then
    query="$(jv_pg_wa_translate_to_en "$query")"
fi

# Prepare request 
request="http://api.wolframalpha.com/v1/spoken?"
request+="appid=$jv_pg_wa_wolfram_api_key"
request+="&i=$(uriencode "$query")"
#jv_debug "Request : $request"


# Run the request
answer=$(curl -s "$request" -H 'Pragma: no-cache' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'Cache-Control: no-cache' -H 'Connection: keep-alive' --compressed)
#jv_debug "Answer : $answer"

# Extract the answer
if [[ "$answer" != "" && "$answer" != "No spoken result available" && "$answer" != "Wolfram Alpha"* ]]
then
	# Translate the result back from english
    if [[ "$jv_pg_wa_lang" != "en" ]]
    then
        answer="$(jv_pg_wa_translate_from_en "$answer")"
    fi

    echo $answer "$(pg_web_answers_lang wa_source "Wolfram")"
else
    echo ""
fi
