# activemq
#
# Meta-state to install activemq.

{% from "activemq/map.jinja" import activemq with context %}

# activemq.server refers to the system's package manager's name for activemq 
# activemq.service refers to the system's service management system's name for activemq

activemq:
  pkg.installed:
    - name: {{ activemq.server }}
  service.running:
    - name: {{ activemq.service }}
    - enable: True

# The following states are inert by default and can be used by other states to
# trigger a restart or reload as needed.
activemq-reload:
  module.wait:
    - name: service.reload
    - m_name: {{ activemq.service }}

activemq-restart:
  module.wait:
    - name: service.restart
    - m_name: {{ activemq.service }}