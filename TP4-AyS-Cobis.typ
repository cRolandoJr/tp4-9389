#set document(title: "TP4 - Automatización y Scripting", author: "Rolando Cobis")
#set text(font: "Liberation Serif", size: 11pt, lang: "es")
#set par(justify: true, leading: 0.62em, spacing: 1.0em)
#set page(paper: "a4", margin: (x: 2.4cm, y: 2.4cm))
#set heading(numbering: none)
#show table: set par(justify: false)
#show raw.where(block: false): set text(font: "Liberation Mono", size: 9pt)
#show raw.where(block: true): it => block(inset: (left: 10pt, y: 4pt), width: 100%, breakable: true, text(font: "Liberation Mono", size: 8pt, it))
#show heading.where(level: 1): it => [#v(0.5em) #block(text(size: 12.5pt, weight: "bold", it)) #v(0.2em)]
#show heading.where(level: 2): it => [#v(0.3em) #block(text(size: 11pt, weight: "bold", it))]
#page(header: none, footer: none, margin: (x: 3cm, y: 3.5cm))[
 #align(center)[
  #text(size: 13pt)[Universidad Nacional del Comahue]

  #text(size: 12pt)[Centro Regional Zona Atlántica]

  Tecnicatura Superior en Administración de Sistemas y Software Libre

  #v(3cm)
  #text(size: 13pt)[Automatización y Scripting]

  #v(0.5cm)
  #text(size: 20pt, weight: "bold")[Trabajo Práctico N.º 4]

  Automatización Avanzada: Contenedores, Ansible y CI/CD

  #v(3cm)
  #block(width: 85%)[
   #set align(left)
   #grid(columns: (1fr, 2fr), row-gutter: 0.6em,
     [*Alumno:*], [Rolando Cobis],
     [*Legajo:*], [CURZA-9389],
     [*DNI:*], [96.495.580],
     [*Docente:*], [Ramiro García Poggi],
     [*Fecha de entrega:*], [5 de noviembre de 2026],
   )
  ]
 ]
]
#counter(page).update(1)
#set page(
 header: [
  #set text(size: 9pt)
  #grid(columns: (1fr, 1fr), align(left)[Rolando Cobis], align(right)[Trabajo Práctico N.º 4])
 ],
 footer: context [
  #set text(size: 9pt)
  #align(center)[Página #counter(page).display("1") de #counter(page).final().at(0)]
 ],
)
#outline(title: [Índice], depth: 2, indent: 1em)
#pagebreak()
= Enunciado del Trabajo Práctico
#set par(spacing: 0.6em)
#text("Objetivo:")

#text("Implementar configuraciones modernas de infraestructura, empaquetar aplicaciones en contenedores ligeros con Docker/Podman, orquestar múltiples servicios utilizando Docker Compose, administrar y aprovisionar servidores de forma declarativa e idempotente usando Ansible Playbooks, y crear un flujo de integración continua (CI/CD) con GitHub Actions.")

#text("Recursos:")

#text("- Bibliografía de la cátedra y de asignaturas anteriores")

#text("- Plataforma PEDCO")

#text("- PC con Ubuntu o un Sistema operativo que soporte bash (puede hacerlo como alternativa con Alpine y sh, el script no será igual probablemente)")

#text("Práctica:")

== Descripción del Caso Práctico

#text("La dirección de TIC de la universidad CURZA requiere implementar un servicio centralizado de análisis de tráfico web para los servidores del campus. El equipo docente ha decidido utilizar GoAccess (un analizador de logs interactivo) junto a servidores web Nginx. Usted debe automatizar el despliegue del software mediante contenedores y Ansible, y a su vez configurar validaciones automatizadas cada vez que se actualice la configuración de la red de laboratorios.")

#text("Requisitos Mínimos y Tareas Prácticas")

== Tarea 1: Contenedores y Orquestación (Docker & Docker Compose)

#text("Dockerfile Personalizado:")

#text("Escriba un archivo `docker/Dockerfile` que use una imagen base de Alpine Linux e instale GoAccess.")

#text("El contenedor debe configurarse para leer los logs desde la ruta `/srv/logs/access.log`.")

#text("Agregue un usuario no-root dentro del contenedor por seguridad.")

#text("Orquestación Multi-Servicio (`docker-compose.yml`):")

#text("Diseñe un archivo `docker/docker-compose.yml` que defina dos servicios coordinados:")

#text("web_server: Levanta un servidor web Nginx utilizando la imagen oficial de Alpine. Debe exponer el puerto `[8000 + Últimos 2 dígitos del legajo]` del host hacia el puerto `80` del contenedor.")

#text("log_analyzer: Levanta su contenedor de GoAccess a partir de su Dockerfile.")

#text("Configure un volumen compartido para que el servidor web escriba sus logs de acceso (`access.log`) y GoAccess los lea e interprete en tiempo real, generando un archivo HTML estático (`report.html`).")

#text("Exponga el reporte interactivo de GoAccess en el puerto `[9000 + Últimos 2 dígitos del legajo]` para que el docente pueda ver los gráficos desde su navegador. GoAccess corre en modo tiempo real escribiendo report.html en un volumen compartido, y Nginx monta ese volumen sirviéndolo en el puerto 9000+XX (o en una ruta /report.html).")

== Tarea 2: Gestión de Configuración Automática con Ansible

#text("Automatice el aprovisionamiento y despliegue del entorno.")

#text("Inventario (`ansible/hosts.ini`):")

#text("Defina un grupo de servidores llamado `[lab_systems]` que apunte a `localhost` (para pruebas locales).")

#text("Configure las variables necesarias para la conexión SSH local y la elevación de privilegios (`become: yes`).")

#text("Playbook de Aprovisionamiento (`ansible/playbook.yml`):")

#text("Escriba un playbook que automatice las siguientes tareas:")

#text("Instalar Docker y sus dependencias en el sistema de destino.")

#text("Copiar los archivos de configuración de Nginx y GoAccess al servidor destino.")

#text("Asegurar que el servicio de Docker esté iniciado y habilitado.")

#text("Levantar los contenedores de Docker Compose utilizando el módulo de Ansible `community.docker.docker_compose_v2` o ejecutando comandos mediante shell.")

#text("Handler: Defina un handler que reinicie el servidor Nginx si se modifica el archivo de configuración.")

== Tarea 3: Integración Continua (CI/CD) con GitHub Actions

#text("Asegure que cualquier cambio de configuración en su infraestructura sea testeado antes de subirse.")

#text("Cree un script simple de pruebas en Python `tests/test_config.py` que valide que el archivo `docker-compose.yml` sea un archivo YAML sintácticamente correcto.")

#text("Cree un pipeline de integración continua configurando un archivo en la ruta `.github/workflows/ci-pipeline.yml`.")

#text("Requisitos del Workflow:")

#text("Debe dispararse ante eventos de `push` o `pull_request` sobre la rama `main`.")

#text("Debe utilizar un runner de Ubuntu moderno (`ubuntu-latest`).")

#text("Debe realizar los siguientes pasos (steps):")

#text("Clonar el código del repositorio (`actions/checkout`).")

#text("Configurar el entorno de Python 3.x (`actions/setup-python`).")

#text("Instalar dependencias necesarias (ej. `pyyaml` para validar el YAML).")

#text("Ejecutar las pruebas de Python utilizando `python -m unittest tests/test_config.py`.")

== Listado de Entregables:

#text("Documento de Informe en formato PDF con: carátula (debe incluir el nombre e identificación del alumno), índice, copia del enunciado del problema a resolver y resolución de los puntos. Incluya todas las hipótesis, supuestos y aclaraciones que considere importante realizar.")

#text("Código completo en un repositorio de Github: deberá estar correctamente indentado y comentado para su sencilla comprensión.")

#text("El trabajo debe entregarse con la siguiente estructura de carpetas:")

#raw("tp4-[legajo]/\n├── README.md (Contiene explicaciones de puertos, links a capturas y diagramas)\n├── .github/\n│ └── workflows/\n│ └── ci-pipeline.yml\n├── docker/\n│ ├── Dockerfile\n│ ├── docker-compose.yml\n│ ├── nginx.conf \n│ └── goaccess.conf\n├── ansible/\n│ ├── hosts.ini\n│ └── playbook.yml\n└── tests/\n└── test_config.py", block: true)

#text("README.md: Incluir capturas de pantalla de la terminal mostrando la ejecución exitosa de los scripts.")

#text("Commits: Debe haber un historial de al menos 3 commits con mensajes claros. Se penalizarán las entregas con un único push final.")

#pagebreak()
= Hipótesis, supuestos y aclaraciones
#set par(spacing: 1.0em)

Usé la VM Ubuntu Server 24.04.5 de los prácticos anteriores. Ejecuté Ansible dentro de esa VM y configuré el inventario para conectar por SSH a `127.0.0.1:4089` como `rolando`. Mantuve ese puerto porque ya estaba configurado en Administración de Servicios.

Calculé 8089 y 9089 con los dos últimos dígitos del legajo. Abrí un túnel SSH desde la laptop para usar `localhost` en el navegador y en la dirección del WebSocket. Para acceso directo por IP dejé la variable `report_host` en el playbook.

Instalé Ansible como preparación del controlador y usé el playbook para instalar Docker y Compose. Probé con una autorización temporal de sudo sin contraseña; para repetir el despliegue sin ella, el comando admite `--ask-become-pass`. Las claves privadas quedaron fuera del repositorio.

Al arrancar encontré el reloj de la VM atrasado. Reinicié chrony y esperé a comprobar la sincronización antes de instalar paquetes. La primera configuración de Nginx duplicaba el formato incorporado `combined`; quité esa declaración y validé con `nginx -t`.

Guardé las salidas de terminal en archivos `.txt` y generé los PNG a partir de esos registros. Para el reporte de GoAccess tomé una captura real del navegador.

#figure(image("capturas/entorno.png", width: 100%), caption: [Entorno y versiones usados en las pruebas.])

#pagebreak()
= Tarea 1: Contenedores y Orquestación (Docker & Docker Compose)

Construí la imagen de GoAccess con Alpine 3.22 y creé el usuario `analyzer` con UID 10001. Configuré la lectura de `/srv/logs/access.log` y la salida HTML en `/srv/reports/report.html`.

Usé dos volúmenes: `access_logs` para los registros y `reports` para el HTML. Nginx escribió los logs y GoAccess los leyó con un montaje de solo lectura. En el volumen del reporte invertí los permisos: GoAccess escribió y Nginx solo leyó.

#table(columns: (2fr, 1fr, 1fr), stroke: 0.5pt, inset: 5pt,
 [*Acceso*], [*Host*], [*Contenedor*],
 [Sitio Nginx], [8089], [80],
 [Reporte y WebSocket], [9089], [90],
 [GoAccess, solo red interna], [Sin publicar], [7890],
)

Hice que GoAccess esperara al chequeo HTTP exitoso de Nginx. Esa petición generó la primera línea del log antes de iniciar el análisis; también quedó contabilizada en el reporte.

#figure(image("capturas/contenedores.png", width: 100%), caption: [Servicios activos, usuario sin root y permisos de los volúmenes.])

#figure(image("capturas/http.png", width: 100%), caption: [Sitio y reporte disponibles por HTTP; archivos compartidos.])

#pagebreak()
== Reporte en tiempo real

Serví el HTML por Nginx y configuré `/ws` como proxy hacia el puerto interno 7890 de GoAccess. Generé seis peticiones a rutas inexistentes y comprobé que el reporte mostró los seis 404. El navegador recibió mensajes nuevos por WebSocket sin recargar.

#figure(image("capturas/goaccess-browser.png", width: 100%), caption: [Reporte de GoAccess en el navegador después de generar tráfico.])

#figure(image("capturas/websocket.png", width: 100%), caption: [Comprobación de la actualización sin recargar la página.])

#pagebreak()
= Tarea 2: Gestión de Configuración Automática con Ansible

Definí el grupo `lab_systems` en `ansible/hosts.ini` y habilité `become` para instalar paquetes y administrar Docker. Copié las configuraciones a `/opt/tp4-9389` y levanté los servicios con `community.docker.docker_compose_v2`.

Ejecuté el playbook desde la raíz del repositorio:

```bash
ansible-playbook -i ansible/hosts.ini ansible/playbook.yml
```

Después de corregir Nginx, completé el despliegue. Repetí el mismo comando sin modificar archivos: terminó con siete tareas correctas, cero cambios y cero errores.


#figure(image("capturas/ansible-sin-cambios.png", width: 100%), caption: [Segunda ejecución: changed=0 y failed=0.])

#pagebreak()
== Handler de Nginx

Agregué un comentario de prueba a `nginx.conf` y repetí el playbook. La copia del archivo notificó al handler `Reiniciar Nginx`. Comparé la hora de inicio del contenedor antes y después y confirmé el reinicio. Luego restauré el archivo original y apliqué nuevamente la configuración.

#figure(image("capturas/ansible-handler.png", width: 100%), caption: [Cambio de configuración y ejecución del handler.])

#pagebreak()
= Tarea 3: Integración Continua (CI/CD) con GitHub Actions

Configuré el workflow para los eventos `push` y `pull_request` sobre `main`, con un runner `ubuntu-latest`. Definí los pasos para preparar Python 3.12, instalar PyYAML y ejecutar la prueba pedida por la consigna.

#raw(read(".github/workflows/ci-pipeline.yml"), lang: "yaml", block: true)

En `tests/test_config.py` cargué `docker/docker-compose.yml` con `yaml.safe_load` y comprobé la presencia de los dos servicios. Probé además un YAML mal formado: el test falló con `ParserError`. Restauré el archivo y volvió a pasar.

#figure(image("capturas/ci-local.png", width: 100%), caption: [Prueba local y control negativo del parser.])

Esta prueba verificó la sintaxis y los nombres de los servicios. Comprobé el funcionamiento del despliegue por separado, con las pruebas HTTP, de permisos y del WebSocket mostradas en la Tarea 1.
