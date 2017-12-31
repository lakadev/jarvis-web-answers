#!/bin/bash
# Here you can create functions which will be available from the commands file
# You can also use here user variables defined in your config file
# To avoid conflicts, name your function like this
# pg_XX_myfunction () { }
# pg for PluGin
# XX is a short code for your plugin, ex: ww for Weather Wunderground
# You can use translations provided in the language folders functions.sh

# Internal variables

jv_pg_wa_lang="$(tr '[:upper:]' '[:lower:]' <<< ${language:0:2})" # en_GB => EN => en
jv_pg_wa_root="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
jv_pg_wa_pup_parser="$jv_pg_wa_root/pup"
jv_pg_wa_engines_folder="$jv_pg_wa_root/engines"

uriencode() {
  s="${1//'%'/%25}"
  s="${s//' '/%20}"
  s="${s//'"'/%22}"
  s="${s//'#'/%23}"
  s="${s//'$'/%24}"
  s="${s//'&'/%26}"
  s="${s//'+'/%2B}"
  s="${s//','/%2C}"
  s="${s//'/'/%2F}"
  s="${s//':'/%3A}"
  s="${s//';'/%3B}"
  s="${s//'='/%3D}"
  s="${s//'?'/%3F}"
  s="${s//'@'/%40}"
  s="${s//'['/%5B}"
  s="${s//']'/%5D}"
  printf %s "$s"
}

jv_pg_wa_translate_to_en()
{
    # “Powered by Yandex.Translate” (http://translate.yandex.com/) 
    # Prepare request 
    local request="https://translate.yandex.net/api/v1.5/tr.json/translate?"
    request+="key=$jv_pg_wa_yandex_key"
    request+="&lang=${jv_pg_wa_lang}-en"
    request+="&text=$(uriencode "$1")"
    #jv_debug "Request : $request"
    
    local translationResult=$(curl -s "$request" -H 'Pragma: no-cache' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'Cache-Control: no-cache' -H 'Connection: keep-alive' --compressed)    
    #jv_debug "Result : $translationResult"
    
    local translatedText=$(echo $translationResult | jq -r '.text[0]')
    #jv_debug "Translation : $translatedText"

    echo $translatedText
}

jv_pg_wa_translate_from_en()
{
    # “Powered by Yandex.Translate” (http://translate.yandex.com/)
    # Prepare request 
    local request="https://translate.yandex.net/api/v1.5/tr.json/translate?"
    request+="key=$jv_pg_wa_yandex_key"
    request+="&lang=en-${jv_pg_wa_lang}"
    request+="&text=$(uriencode "$1")"
    #jv_debug "Request : $request"
    
    local translationResult=$(curl -s "$request" -H 'Pragma: no-cache' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: fr-FR,fr;q=0.9,en-US;q=0.8,en;q=0.7' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 9_1 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13B143 Safari/601.1' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'Cache-Control: no-cache' -H 'Connection: keep-alive' --compressed)    
    #jv_debug "Result : $translationResult"
    
    local translatedText=$(echo $translationResult | jq -r '.text[0]')
    #jv_debug "Translation : $translatedText"
    
    echo $translatedText
}

jv_pg_wa_search()
{
  # Start thinking...
  reflexionPid=""
  say "$(pg_web_answers_lang wa_preparing_phrase)" > /dev/tty & 
  reflexionPid="$!"

  answer=""

  for i in "${!jv_pg_wa_engines[@]}"; do 
    engine="$jv_pg_wa_engines_folder/${jv_pg_wa_engines[$i]}"
    #jv_debug "Engine = $engine"
    
    if [[ -x $engine ]]
    then
      answer=$(source "$engine" "$order")

      if [[ ! -z "$answer" ]]
      then
          wait "$reflexionPid"
          echo $answer
          break
      fi
    fi

  done

  if [[ -z "$answer" ]]
  then
      wait "$reflexionPid"
      echo "$(pg_web_answers_lang wa_not_found)"
  fi
}