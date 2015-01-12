# instances.debian
#
# Manages activemq instances for Debian

{% from "activemq/map.jinja" import activemq with context %}

include:
  - activemq


{% if grains['os_family']=="Debian" %} # Protection against non-debian environments as to not destroy them
{% for id, instance in salt['pillar.get']('activemq:instances', {}).items() %}

{{ activemq.instance_available_path }}/{{ id }}:
  file.directory:
    - user: {{ activemq.user }}
    - group: {{ activemq.group }}
    - mode: 755
    - makedirs: True

{{ id }}:
  file:
    - managed
    - name: {{ activemq.instance_available_path }}/{{ id }}/activemq.xml
    - source: 'salt://activemq/templates/activemq.xml.template'
    - template: 'jinja'
    - context: #not sure if we need to override this like this
        id: {{ id|json }}
        instance: {{ instance|json }}
        activemq: {{ activemq|json }}
    - require:
      - pkg: activemq
    - watch_in:
      - module: activemq-restart #restart to make sure changes and new instances are activated

##TODO:
# - Add enable/disable checks and actuators to add and remove symlinks
# - Add logging file from defaults
# - Add actual modifiables in the activemq.xml template and make sure the context overrides are actually needed

{% endfor %}
# End: for loop instances
{% endif %}
# End: os_family = debian