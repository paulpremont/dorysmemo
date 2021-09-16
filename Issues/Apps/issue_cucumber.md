# Cucumber's issues

## Erreur "wrong number of arguments"

Erreur avec cucumber-nagios:

Message :

    wrong number of arguments (8 for 7) (ArgumentError)

### Lien

[github](https://github.com/auxesis/cucumber-nagios/issues/86)

### Résolution

Substituer :

    def after_step_result(keyword, step_match, multiline_arg, status, exception, source_indent, background, *tmp)
            record_result(status, :step_match => step_match, :keyword => keyword)
    end

à la place de :

    def after_step_result(keyword, step_match, multiline_arg, status, exception, source_indent, background)
            record_result(status, :step_match => step_match, :keyword => keyword)
    end

Dans:

    /usr/local/rvm/gems/ruby-2.1.1@cucumber/gems/cucumber-nagios-0.9.2/lib/cucumber/formatter/nagios.rb:16:in `after_step_result'

(Voir la première ligne d'erreur)

Il est aussi possible de downgrader sa version de cucumber en 1.1.2 apparament.

Note:

I removed «cucumber-1.2.1» and «gherkin-2.11.2» (dependency).
so that is installed (gem list) :
cucumber (1.1.9, 1.1.3)
cucumber-nagios (0.9.2)
