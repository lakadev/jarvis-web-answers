#!/bin/bash
# Here you can define translations to be used in the plugin functions file
# the below code is an sample to be reused:
# 1) uncomment to function below
# 2) replace XXX by your plugin name (short)
# 3) remove and add your own translations
# 4) you can the arguments $2, $3 passed to this function
# 5) in your plugin functions.sh file, use it like this:
#      say "$(pv_myplugin_lang the_answer_is "oui")"
#      => Jarvis: La réponse est oui

pg_web_answers_lang () {
   case "$1" in
	wa_preparing_phrase) echo "Je recherche sur internet...";;
	wa_not_found) echo "Désolé, je n'ai pas trouvé la réponse.";;
	wa_source) echo "d'après $2";;
   esac
} 
