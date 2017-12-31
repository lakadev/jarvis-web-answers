#!/bin/bash

# Wofram Api Key - required for Wolfram search engine
jv_pg_wa_wolfram_api_key="YOUR_WOLFRAM_API_KEY"

# Yandex Translator Key - required if Jarvis language is not english for Wolfram search engine
jv_pg_wa_yandex_key="YOUR_YANDEX_TRANSLATOR_API_KEY"

# Search engines - (scripts in 'engines/' folder)
jv_pg_wa_engines[0]="google-search.sh"
jv_pg_wa_engines[1]="wolfram-alpha.sh"
