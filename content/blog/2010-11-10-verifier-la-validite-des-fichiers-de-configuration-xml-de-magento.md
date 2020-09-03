---
title: "Vérifier la validité des fichiers de configuration XML de Magento"
date: 2010-11-10
tags:
  - Magento
image: /images/xml.png
---

Pour rappel, Magento s'appuie sur des fichiers [XML pour configurer ses modules](http://www.magentocommerce.com/wiki/5_-_modules_and_development/reference/module_config.xml) (entre autre). Le soucis avec l’utilisation qu'en fait Magento, c'est qu'il ne vérifie pas l'intégrité des fichiers XML.

En effet, si vous faite une faute de frappe, qu'une balise est mal fermé ou tout être erreur dans la structure XML de votre fichier de configuration, Magento levera une erreur (ou plutôt un warning) du type :

```php
Warning: simplexml_load_string() [function.simplexml-load-string]: Entity: line 19: parser error : expected '>' in magento\lib\Varien\Simplexml\Config.php on line 510
```
<!-- excerpt -->
Notes :
* ce message est loggué dans `system.log` (si les logs sont activés)
* dans le cas où le `DeveloperMode` n'est pas activée, l'erreur sera silencieuse

Vous me direz, ça n'est pas bloquant : un coup d'oeil dans le fichier `exception.log` pour déterminer l'origine du problème et l'affaire est réglée ! Sauf que non, ce type d'erreur n'est pas "protégée" par un try/catch...
De ce fait, mise à part le fait de savoir qu'un fichier XML de configuration est en cause, vous n'êtes pas très avancé.

L'idée, pour se simplifier, est de connaitre le nom (où plutôt le chemin) du fichier en cause et la ligne qui pose problème.

Pour cela, je vous propose un overlap de classe `Varien` en charge des fichiers de configuration XML : [`Varien_Simplexml_Config`](http://docs.magentocommerce.com/Varien/Varien_Simplexml/Varien_Simplexml_Config.html). Le code est simple et mériterait d'être retravaillé, mais il fonctionne bien en l'état.

`app/code/local/Varien/Simplexml/Config.php` :

```php
class Varien_Simplexml_Config {
    [...]
    /**
     * Imports XML file
     *
     * @param string $filePath
     * @return boolean
     */
    public function loadFile($filePath)
    {
        if (!is_readable($filePath)) {
            //throw new Exception('Can not read xml file '.$filePath);
            return false;
        }

        $fileData = file_get_contents($filePath);
        $fileData = $this->processFileData($fileData);
        /**
         * Custom code: $filePath added
         */
        // original
        //return $this->loadString($fileData, $this->_elementClass);
        // new
        return $this->loadString($fileData, $this->_elementClass, $filePath);
    }

    /**
     * Imports XML string
     *
     * @param  string $string
     * @return boolean
     */
    public function loadString($string)
    {
        if (is_string($string)) {
            /**
             * Custom code: dealing with config file XML errors
             */
            libxml_use_internal_errors(true);
            $xmlcheck = simplexml_load_string($string);
            if (!is_object($xmlcheck)) {
                $argslist = func_get_args();
                $filePath = $argslist[2];
                foreach(libxml_get_errors() as $error) {
                    $error = array(
                        'message' => trim($error->message),
                        'code'    => 'Code: ' . $error->code,
                        'file'    => 'File: ' . ($error->file != '' ? $error->file : $filePath),
                        'line'    => 'Line: ' . $error->line,
                        'column'  => 'Column: ' . $error->column,
                    );
                }
                libxml_clear_errors();
                // log
                Mage::log("\n" . implode("\n", $error), Zend_Log::ERR, 'exception_config.log');
                // throw in developer mode
                if (Mage::getIsDeveloperMode()) {
                    Mage::printException(new Exception(implode("\n", $error)), 'CONFIG FILE ERROR');
                }
            }
            // /Custom code
            $xml = simplexml_load_string($string, $this->_elementClass);

            if ($xml instanceof Varien_Simplexml_Element) {
                $this->_xml = $xml;
                return true;
            }
        } else {
            Mage::logException(new Exception('"$string" parameter for simplexml_load_string is not a string'));
        }
        return false;
    }
    [...]
}
```

Le principe est très simple : je me contente d'utiliser l'outillage founi par PHP et libxml via `libxml_use_internal_errors()` :

* j'active le gestionnaire d'erreur de la librairie
* je contrôle le fichier XML chargé dont je connais le chemin via `$filePath`
* en cas d'erreurs, je les compile dans un tableau
* j'enregistre ces erreurs (message, code, fichier, ligne et colonne) dans un fichers de log dédié
* si le `DeveloperMode` est activée, je lève une _exception_ bien violente

Voilà, c'est tout simple et le résultat est tout de même plus explicite :

```
CONFIG FILE ERROR
expected '>'
Code: 73
File: magento\app\code\local\Narno\MonModule\etc\config.xml
Line: 20
Column: 1
```

Il semblerait que j'ai mal fermé une balise à la ligne 20 du fichier de configuration de `MonModule` ! :-)

Encore une fois j'insiste sur le fait qu'il s'agit d'un _overlap_ simple et perfectible (et surtout bourrin). Si vous avez des idées d'amélioration, n'hésitez pas ! :-)

Pour aller plus loin dans la validation des fichiers XML de Magento, il serait nécessaire de valider leur schéma via une DTD (via l'option `LIBXML_DTDVALID` de l'objet `SimpleXMLElement`), mais le chantier s'annonce long et pénible...

*[XML]: Extensible Markup Language  
*[DTD]: Document type definition

_Initialement publié sur [Narno.com](http://narno.com/blog/verifier-la-validite-des-fichiers-de-configuration-xml-de-magento)._
