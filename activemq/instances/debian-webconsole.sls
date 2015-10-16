{% from "activemq/map.jinja" import activemq with context %}

activemq-enable-debian-webconsole-libraries:
  file.recurse:
    - name: /usr/share/activemq/lib
    - source: 'salt://activemq/files/lib'
    - makedirs: True
    - user: {{ activemq.user }}
    - group: {{ activemq.group }}

activemq-enable-debian-webconsole-webapp:
  file.recurse:
    - name: /usr/share/activemq/webapps
    - source: 'salt://activemq/files/webapps'
    - makedirs: True
    - user: {{ activemq.user }}
    - group: {{ activemq.group }}
