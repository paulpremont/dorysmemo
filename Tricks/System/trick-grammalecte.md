# Grammalecte

## Sources 

* https://grammalecte.net/#download
* https://github.com/dpelle/vim-Grammalecte

## Vim install

https://github.com/dpelle/vim-Grammalecte/blob/master/doc/Grammalecte.txt

1. récupérer le plugin au niveau des sources
  => Fichiers à mettre dans ~/.vim
2. télécharger l'archive grammalecte (cli)
  => unzip et mettre à un endroit sûr

Dans son .vimrc :

```
set nocompatible                                                                
filetype plugin on                                                              
let g:grammalecte_cli_py='$HOME/Software/Grammalecte-fr-v2.1.1/grammalecte-cli.py'
```

Pour solliciter grammalecte :

:GrammalecteCheck
