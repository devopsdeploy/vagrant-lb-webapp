{% from "webserver/map.jinja" import nginx %}

install_nginx:
  pkg.installed:
    - name: {{ nginx.package }}
    - force_yes: True
  group.present:
    - name: {{ nginx.group }}
    - system: True
  user.present:
    - name: {{ nginx.user }}
    - gid: {{ nginx.group }}
    - system: True

reload-nginx:
  service.running:
    - name: {{ nginx.service }}
    - enable: True
    - reload: True
    - watch:
      - module: nginx-config-test

nginx-config-test:
  module.wait:
    - name: nginx.configtest
