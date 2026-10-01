#show link: underline

#let img(imagePath, caption, supplement: [Рисунок]) = {
  align(center)[
    #figure(image(imagePath), caption: caption, supplement: supplement)
  ]
}


#set page(
  paper: "a4",
  numbering: "1",
)

#set par(
  justify: true,
  first-line-indent: (
    amount: 1.25cm,
    all: true,
  ),
  spacing: 0.65em,
)

#set text(
  lang: "ru",
  font: "Times New Roman",
  size: 14pt,
)

#set page(footer: context {
  if counter(page).get().first() > 1 [
    #align(center)[
      #counter(page).display("1")
    ]
  ]
  if counter(page).get().first() == 1 [
    #align(center)[
      Санкт-Петербург \ 2026
    ]
  ]
})

#set page(header: context {
  if counter(page).get().first() == 1 [
    #align(center)[
      *Министерство науки и высшего образования Российской Федерации* \
    ]
  ]
})

#show raw: set text(font: "Consolas")
#show raw.where(block: false): box.with(
  fill: luma(240),
  inset: (x: 3pt, y: 0pt),
  outset: (y: 3pt),
  radius: 2pt,
)

#show raw.where(block: true): block.with(
  fill: luma(240),
  inset: 10pt,
  radius: 4pt,
)

// title

#align(center)[
  ФЕДЕРАЛЬНОЕ ГОСУДАРСТВЕННОЕ АВТОНОМНОЕ ОБРАЗОВАТЕЛЬНОЕ УЧРЕЖДЕНИЕ ВЫСШЕГО ОБРАЗОВАНИЯ
]

#align(center)[
  #text(size: 12pt)[
    \ *НАЦИОНАЛЬНЫЙ ИССЛЕДОВАТЕЛЬСКИЙ УНИВЕРСИТЕТ ИТМО*
  ]
]

#align(center)[
  \ *ITMO University*
]


#for _ in range(5) { linebreak() }

#align(center)[*ЛАБОРАТОРНАЯ 1*]

#table(
  stroke: white,
  columns: 1,
  inset: 10pt,

  [*По дисциплине* Контейнеризация и оркестрация приложений],
  [*Тема работы* Знакомство с экосистемой Docker: от базовых команд к диагностике сервиса],
  [*Обучающийся* Дощенников Никита Андреевич],
  [*Факультет* Прикладной информатики],
  [*Группа* К3321],
  [*Направление подготовки* 11.03.02 Инфокоммуникационные технологии и системы связи],
  [*Образовательная программа* Программирование в инфокоммуникационных системах],
  [],
)

#table(
  stroke: white,
  columns: 4,
  inset: 10pt,

  table.cell(align: top)[*Обучающийся*],

  table(
    columns: 1,
    inset: 2pt,
    stroke: white,
    table.cell(
      align: top + center,
    )[#text(size: 10pt, fill: white)[.]],
    [#line(length: 100pt)],
  ),

  table(
    columns: 1,
    inset: 2pt,
    stroke: white,
    table.cell(
      align: top + center,
    )[#text(size: 11pt, fill: white)[.]],
    [#line(length: 100pt)],
  ),

  table(
    columns: 1,
    inset: 2pt,
    stroke: white,
    table.cell(
      align: top + center,
    )[#text(size: 10pt)[Дощенников Н.А.]],
    [#line(length: 100pt)],
  ),

  [],
  table.cell(align: center)[#text(size: 10pt)[(дата)]],
  table.cell(align: center)[#text(size: 10pt)[(подпись)]],
  table.cell(align: center)[#text(size: 10pt)[(Ф.И.О.)]],

  table.cell(align: top)[*Руководитель*],

  table(
    columns: 1,
    inset: 2pt,
    stroke: white,
    table.cell(
      align: top + center,
    )[#text(size: 10pt, fill: white)[.]],
    [#line(length: 100pt)],
  ),

  table(
    columns: 1,
    inset: 2pt,
    stroke: white,
    table.cell(
      align: top + center,
    )[#text(size: 11pt, fill: white)[.]],
    [#line(length: 100pt)],
  ),

  table(
    columns: 1,
    inset: 2pt,
    stroke: white,
    table.cell(
      align: top + center,
    )[#text(size: 10pt)[Аминов Н.С.]],
    [#line(length: 100pt)],
  ),

  [],
  table.cell(align: center)[#text(size: 10pt)[(дата)]],
  table.cell(align: center)[#text(size: 10pt)[(подпись)]],
  table.cell(align: center)[#text(size: 10pt)[(Ф.И.О.)]],
)


#pagebreak()

#outline(title: [Содержание])

#pagebreak()
= Персональные параметры

#align(center)[
  #figure(
    table(
      columns: 2,
      inset: 10pt,
      align: horizon + center,
      table.header([*Параметр*], [*Значение*]),
      [Номер ИСУ], [_465797_],
      [Персональный порт], [_#(5430 + 97)_],
      [Персональный префикс], [_doschennikov_],
    ),
    caption: [Персональные параметры],
  )
]

#pagebreak()
= Этап 1. Верификация окружения и архитектуры

== Задание 1.1

Я проверил установку Docker командой:

```bash
docker version --format "Client: {{.Client.Version}}, Server: {{.Server.Version}}"
```

#img("assets/1.png", [Проверка установки Docker])

- Версия клиента: `29.8.1`
- Версия сервера: `29.8.1`

Я узнал тип ОС и архитектуры при помощи:

```bash
docker info --format "{{.OSType}}/{{.Architecture}}"
```

Вывод:
```text
linux/x86_64
```

#img("assets/2.png", [Проверка типа ОС и архитектуры])

== Задание 1.2

Я исследовал состояние локального хранилища командой:

```bash
docker system df --format "table {{.Type}}\t{{.TotalCount}}\t{{.Active}}\t{{.Size}}"
```

#img("assets/3.png", [Локальное хранилище])

- До начала работы хранится 0 образов.
- Сейчас активно 0 запущенных контейнеров.

== Задание 1.3

Затем я попытался вывести информацию о текущей сессии командой из условия работы:

```bash
echo "Student: $(whoami)@$(hostname)" && \
echo "Date: $(date '+%Y-%m-%d %H:%M:%S')" && \
docker version --format "Docker {{.Server.Version}} on {{.Server.Os}}/{{.Server.Architecture}}"
```

И получил следующую ошибку:

#img("assets/4error.png", [Ошибка при попытке вывода информации])

Дело в том, что у `.Server` отсутствует поле `.Architecture`. Я исправил команду следующим образом:

```bash
echo "Student: $(whoami)@$(hostname)" && \
echo "Date: $(date '+%Y-%m-%d %H:%M:%S')" && \
docker version --format "Docker {{.Server.Version}} on {{.Server.Os}}/{{(index .Server.Components 0).Details.Arch}}"
```

#img("assets/4.png", [Удачная попытка])

- Команда #link("https://docs.docker.com/reference/cli/docker/system/prune/")[`docker system prune`] без флагов удаляет остановленные контейнеры, неиспользуемые сети, а также только висячие ("dangling") образы и соответствующий неиспользуемый #link("https://docs.docker.com/build/cache/")[кэш сборки]. Локальные тома по умолчанию не удаляются, для их удаления необходимо дополнительно указать флаг #link("https://docs.docker.com/reference/cli/docker/system/prune/#options")[`--volumes`]. Перед удалением Docker запрашивает подтверждение пользователя. Таким образом, могут быть потеряны остановленные контейнеры, неиспользуемые сети, висячие образы и часть кэша сборки.
- `docker version` может завершиться ошибкой в основниом по нескольким причинам:
  - Не установлены параметры окружения. Информацию об этой проблеме я нашел #link("https://stackoverflow.com/questions/37527888/docker-commands-fails-in-windows/39350770")[здесь].
  - Не включен `docker.service`. Включить можно командой:
    ```bash
    systemctl enable --now docker.service
    ```
    #img("assets/5.png", [Ошибка при вызове `docker version`.])

#pagebreak()
= Этап 2. Первые шаги: «игрушечные» образы

== Задание 2.1

Я запустил классический пример командой:

```bash
docker run --rm hello-world
```

#img("assets/6.png", [Результат исполнения hello-world.])

- Образ загружается из Docker Hub: `docker.io/library/hello-world:latest`.

- Внутри контейнера выполняется бинарный файл `/hello`. Он является главным процессом контейнера (PID 1), выводит сообщение `Hello from Docker!` и после этого завершается.

- Последовательность работы выглядит следующим образом: Docker проверяет наличие образа в локальном кэше. Если образ отсутствует, он загружается из Docker Hub. После этого Docker создаёт контейнер и запускает в нём `/hello`. Вывод процесса передаётся Docker-клиенту и отображается в терминале.

== Задание 2.2

Я исследовал минимальный образ:

```bash
docker run --rm alpine:3.18 cat /etc/os-release
```

#img("assets/7.png", [Вывод `/etc/os-release` образа `alpine:3.18`])

Затем я посмотрел размер образа:

```bash
docker images alpine:3.18 --format "{{.Size}}"
```

#img("assets/8.png", [Размер образа `alpine:3.18`])

- Значение поля `PRETTY_NAME`: "Alpine Linux v3.18"
- Размер образа: 12.5 MB

== Задание 2.3

Я сравнил поведение двух контейнеров:

```bash
docker run -d --name doschennikov-alpine-1 alpine:3.18 sleep 300
docker run -d --name doschennikov-alpine-2 alpine:3.18 sh -c "echo 'Hello from $(hostname)' && sleep 300"
```

И проверил их статус:

```bash
docker ps --filter "name=doschennikov-alpine"
```

#img("assets/9.png", [Статус контейнеров])

Второй контейнер ожидаемо выводит сообщение:

```bash
docker logs doschennikov-alpine-1
docker logs doschennikov-alpine-2
```

#img("assets/10.png", [Логи контейнеров])



- Контейнер `hello-world` завершается сразу после запуска, потому что его главный процесс (PID 1) `/hello` выполняет свою задачу, выводит сообщение и завершается. Когда главный процесс контейнера завершается, контейнер также переходит в состояние `Exited`. Флаг `--rm` не влияет на продолжительность работы контейнера, а только указывает Docker автоматически удалить контейнер после его завершения. В случае `alpine:3.18` главным процессом является команда `sleep 300`, которая не завершается в течение 300 секунд, поэтому контейнер остаётся в состоянии `Up` примерно 5 минут.

- Если убрать флаг `--rm` из команды `docker run --rm hello-world`, контейнер всё равно завершится после завершения процесса `/hello`. Отличие заключается в том, что Docker не удалит его автоматически, а контейнер останется в состоянии `Exited` и будет отображаться командой `docker ps -a`. Удалить такие остановленные контейнеры можно командой `docker container prune` или удалить конкретный контейнер командой `docker rm`.
  #img("assets/11.png", [Оставшиеся образы])
  #img("assets/12.png", [Удаление оставленных контейнеров])

#pagebreak()
= Этап 3. Жизненный цикл контейнера

== Задание 3.1

Я проследил все состояния через последовательные команды:

1. Создание без запуска
  ```sh
  docker create --name doschennikov-nginx nginx:alpine
  ```
  #img("assets/13.png", [Создание без запуска])

2. Запуск
  ```sh
  docker start doschennikov-nginx
  ```
  #img("assets/14.png", [Запуск контейнера])

3. Остановка "мягкая" (сигнал `SIGTERM`)
  ```sh
  docker stop doschennikov-nginx
  ```
  #img("assets/15.png", [Остановка контейнера "мягкая"])

4. Перезапуск
  ```sh
  docker restart doschennikov-nginx
  ```
  #img("assets/16.png", [Перезапуск контейнера])

5. Остановка "жесткая" (сигнал `SIGKILL`)
  ```sh
  docker kill doschennikov-nginx
  ```
  #img("assets/17.png", [Остановка контейнера "жесткая"])

6. Удаление
  ```sh
  docker rm doschennikov-nginx
  ```
  #img("assets/18.png", [Удаление контейнера])

== Задание 3.2

Я зафиксировал переходы состояний командой:

```sh
docker ps -a --filter "name=doschennikov-nginx" --format "table {{.Names}}\t{{.Status}}\t{{.CreatedAt}}"
```

1. До создания контейнера:
  #img("assets/19.png", [Состояние до создания контейнера])

2. После создания контейнера:
  #img("assets/20.png", [Состояние после создания контейнера])

3. После запуска:
  #img("assets/21.png", [Состояние после запуска контейнера])

4. После "мягкой" остановки (`SIGTERM`):
  #img("assets/22.png", [Состояние после остановки `SIGTERM`])

5. После перезапуска:
  #img("assets/23.png", [Состояние после перезапуска])

6. После "жесткой" остановки (`SIGKILL`):
  #img("assets/24.png", [Состояние после остановки `SIGKILL`])

7. После удаления:
  #img("assets/25.png", [Состояние после удаления])


#align(center)[
  #figure(
    table(
      align: horizon + center,
      inset: 10pt,
      fill: (x, y) => if (y == 0) { gray },
      columns: 3,
      table.header("Шаг", "Команда", "STATUS"),
      [1], [`docker create --name doschennikov-nginx nginx:alpine`], [`Created`],
      [2], [`docker start doschennikov-nginx`], [`Up`],
      [3], [`docker stop doschennikov-nginx`], [`Exited`],
      [4], [`docker restart doschennikov-nginx`], [`Up`],
      [5], [`docker kill doschennikov-nginx`], [`Exited`],
      [6], [`docker rm doschennikov-nginx`], [контейнер удалён],
    ),
    caption: [Состояния],
    supplement: [Табл.],
  )
]

1. #link("https://docs.docker.com/reference/cli/docker/container/stop/")[`docker stop`] по умолчанию отправляет `SIGTERM` и через "grace period" (по умолчанию на linux - 10 сек, на windows - 30 сек; флаг #link("https://docs.docker.com/reference/cli/docker/container/stop/#timeout")[`--timeout`] (`-t`) позволяет установить свое значение) отправляется `SIGKILL`. Тем не менее первый сигнал можно поменять при помощи флага #link("https://docs.docker.com/reference/cli/docker/container/run/#stop-signal")[`--stop-signal`] или инструкции `STOPSIGNAL` в Dockerfile контейнера.
2. #link("https://docs.docker.com/reference/cli/docker/container/kill/")[`docker kill`] отправляет главному процессу #link("https://web.archive.org/web/20060614120740/http://graphics.stanford.edu/~monzy/KillDashNine.mp3")[`SIGKILL`] (сигнал можно специфицировать флагом #link("https://docs.docker.com/reference/cli/docker/container/kill/#signal")[`--signal`]), который вызывает немедленное завершение процесса. Если в момент отправления сигнала происходят взаимодействия с базой, то они могут быть не завершены корректно, что в свою очередь приведет к потере или повреждению данных.

- Если выполнить #link("https://docs.docker.com/reference/cli/docker/container/rm/")[`docker rm`] для запущенного контейнера без дополнительных параметров, Docker не удалит его и вернёт ошибку о том, что контейнер запущен. Для удаления запущенного контейнера принудительно используется флаг #link("https://docs.docker.com/reference/cli/docker/container/rm/#force")[`-f`] (`--force`). В этом случае Docker сначала принудительно завершает главный процесс контейнера, отправляя ему `SIGKILL`, после чего удаляет контейнер.

#pagebreak()
= Этап 4. Диагностика реального сервиса

== Задание 4.1

Я запустил контейнер с ошибкой:

```sh
docker run -d \
  --name doschennikov-pg-broken \
  -p 5527:5432 \
  postgres:15
```

#img("assets/26.png", [Запуск контейнера])

Я проверил статус контейнера:

```sh
docker ps -a --filter "name=doschennikov-pg"
```

#img("assets/27.png", [Статус контейнера])

Затем я вывел логи с временной меткой:

```sh
docker logs --timestamps doschennikov-pg-broken 2>&1 | tail -20
```

#img("assets/28.png", [Логи с временной меткой])

Код завершения:

```sh
docker inspect doschennikov-pg-broken --format='{{.State.ExitCode}}'
```

#img("assets/29.png", [Код завершения])


== Задание 4.2

Исправил и проверил:

```sh
docker run -d \
  --name doschennikov-pg-fixed \
  -e POSTGRES_PASSWORD=Pass_5527 \
  -e POSTGRES_USER=user_465797 \
  -p 5527:5432 \
  postgres:15
```

#img("assets/30.png", [Исправленный вариант])

Проверка работоспособности:

```sh
docker exec doschennikov-pg-fixed psql -U user_465797 -c "SELECT version();"
```

#img("assets/31.png", [Результат проверки])

== Задание 4.3

Финальный артефакт:

```sh
echo "=== Практика №1: $(date '+%Y-%m-%d %H:%M:%S') ===" && \
echo "Студент: $(whoami)@$(hostname)" && \
docker ps --filter "name=doschennikov-pg-fixed" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
```

#img("assets/32.png", [Финальный артефакт])

#pagebreak()
= Вывод

В ходе практической работы были изучены основные команды Docker, работа с образами и контейнерами, их жизненный цикл и диагностика ошибок. Были рассмотрены запуск, остановка, перезапуск и удаление контейнеров, а также работа с Docker Engine и PostgreSQL. Полученные навыки позволяют выполнять базовое управление контейнерами и диагностировать проблемы при их запуске.

