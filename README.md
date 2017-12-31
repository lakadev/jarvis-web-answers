## Description
**Plugin pour répondre à des questions en cherchant sur internet.**

Les questions qui peuvent être traitées dans cette version sont des questions *précises* de science et de culture générale. 

Lorsque une question est posée, le plugin effectue une recherche sur internet en utilisant différents moteurs. Le plugin permet l'ajout facile de nouveau moteurs pour répondre à plus de questions.

Les moteurs implémentés sont :
- **Google** : effectue une recherche **Google** classique et retourne la réponse fournie dans la section "Featured Snipet" si elle est disponible.
- **Wolfram|Alpha** : utilise la fonctionnalité "Spoken Results" du très puissant moteur **Wolfram|Alpha** pour répondre de façon concise à la question.

**Wolfram** n'étant disponible qu'en Anglais, une traduction automatique de la question et de la réponse est effectuée.
Le moteur de traduction utilisé est **Yandex** : **[“Powered by Yandex.Translate”](http://translate.yandex.com/)**

Il est préférable de placer ce plugin à la fin de la liste des plugins Jarvis pour éviter de bloquer les autres plugins plus spécialisés.

## Usage

```
Vous: Quelle est la hauteur de la tour Eiffel ?
Jarvis: Je recherche sur internet...
Jarvis: 300m d'après Google

Vous: Combien pèse un litre de mercure ?
Jarvis: Je recherche sur internet...
Jarvis: La réponse est environ 13,5 kg d'après Wolfram
```

Les questions doivent être très précises, par exemple :
"Combien pèse une baleine ?" => **KO**
"Combien pèse une baleine bleue ?" => **OK**
ou encore
"Quelle est la vitesse du son ?" => **KO**
"Quelle est la vitesse du son dans l'air ?" => **OK**

## Prérequis

Une clef **Wolfram|Alpha** est requise pour utiliser le moteur Wolfram.
- Se rendre sur le [site Wolfram](http://products.wolframalpha.com/api)
- Créer un compte gratuit ("Get Started for Free").
- Ajouter une nouvelle application pour obtenir une clef d'API (format 'XXXXXX-XXXXXXXXXX').
- Enfin renseigner cette clef dans la configuration du plugin.

Pour les non anglophones, une clef **Yandex Translator** est requise.
Elle peut être obtenue gratuitement en s'inscrivant sur [le site Yandex](https://translate.yandex.com/developers)
L'API **Yandex Translator** permet de traduire gratuitement jusqu'à 1 000 000 caractères par jour, et jusqu'à 10 000 000 caractères par mois.

## Dépendences

Ce plugin utilise l'excelent parseur html [Pup](https://github.com/ericchiang/pup).
Le module sera téléchargé lors de l'installation (~5Mb).

## Contribuer

Vous pouvez ajouter de nouveaux moteurs de recherche en 2 étapes :
1) Ajouter un script éxécutable dans le dossier `engines/` 
Ce script reçoit en entrée `$1` la question posée.
Il doit écrire la réponse textuelle dans la sortie standard ou une chaîne vide `""` si aucune réponse n'a été trouvée.
Il est possible d'utiliser dans les scripts les fonctions utilitaires suivantes :
```
	uriencode 	# encode la chaîne passée en paramètre pour une utilisation dans une requête web
	jv_pg_wa_pup_parser # sélectionne des éléments dans une chaîne html en utilisant des sélecteurs CSS classiques.
	translate_to_en # traduit une châine de la langue courante de Jarvis vers l'anglais
	translate_from_en # traduit une châine de l'anglais vers la langue courante de Jarvis 
```

2) Déclarer le moteur dans le fichier de configuration
```
jv_pg_wa_engines[2]="reponse-a-tout.sh"
```

Les moteurs seront appelés dans l'ordre du tableau jusqu'à ce que l'un d'eux renvoi une réponse non vide.

A vous de jouer !

---


----------- English Version -----------


## Description
**Plugin to find answers by doing internet searchs.**

The questions that can be addressed yet are precise questions of science and general knownledge. 

When a question is asked, the plugin searches the internet using different engines. The plugin makes it easy to add new engines to answer more questions.


The implemented engines are:
- **Google**: performs a classic **Google** search and returns the answer provided in the "Featured Snipet" section if available.
- **Wolfram|Alpha**: uses the "Spoken Results" feature of the powerful **Wolfram|Alpha** engine to concisely answer the question.


Since **Wolfram** is only available in English, an automatic translation of the question and the answer is done.
The translation engine used is **Yandex** : **[“Powered by Yandex.Translate”](http://translate.yandex.com/)**

It is better to put this plugin at the end of the list of Jarvis plugins to avoid blocking more specialized plugins.

## Usage

```
You: How tall is the Eiffel Tower?
Jarvis: I check on the Internet...
Jarvis: 300m according to Google

You: How much does a liter of mercury weigh?
Jarvis: I check on the Internet...
Jarvis: The answer is about 13.5 kg according to Wolfram
```

The questions should be very precise, for example:
"How much does a whale weigh?" => **KO**
"How much does a blue whale weigh?" => **OK**
or
"What is the speed of sound?" => **KO**
"What is the speed of sound in the air?" => **OK**

## Prerequisite

A **Wolfram|Alpha** API key is required to use the Wolfram engine.
To obtain a free API key :
 - Visit the [Wolfram website](http://products.wolframalpha.com/api)
 - Create a free account ("Get Started for Free").
 - Add a new application to get an API key (format 'XXXXXX-XXXXXXXXXX').
 - Finally report this key in the plugin configuration.

For non-English speakers, a **Yandex Translator** key is required.
It can be obtained for free by registering on the **[Yandex website](https://translate.yandex.com/developers)**
The **Yandex Translator** API allows free translation up to 1,000,000 characters per day, and up to 10,000,000 characters per month.

## Dependencies

This plugin uses the excelent html parser [Pup](https://github.com/ericchiang/pup).
The module will be downloaded during the installation (~5Mb).

## Contribute

You can add new search engines in 2 steps:
1) Add an executable script in the `engines/` folder
This script will receive the question asked as an input `$1`.
It must write the textual response in the standard output or an empty string `""` if no response was found.
It is possible to use the following utility functions in the scripts:
```
	uriencode # encode the string passed in parameter for use in a web request
	jv_pg_wa_pup_parser # selects elements in an html string using classic CSS selectors.
    translate_to_en # translates a string of the current Jarvis language into English
    translate_from_en # translate a string from English to the current Jarvis language
```

2) Declare the engine in the configuration file
```
    jv_pg_wa_engines [2] = "reponse-a-tout.sh"
```

The engines will be called in the order defined in the array until one of them returns a non-empty response.

Your turn to play !

## Author
[Lakadev](http://www.lakadev.com)
