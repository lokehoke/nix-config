# Состав для ревью

Это предложение по результатам ревизии, а не согласованный список установок. До ревью конфигурация не применяется. Список ниже описывает текущее содержимое PR и отдельно перечисляет незавершённые части миграции.

## Предложено в этом PR

| Категория | Программы и настройки | Профиль |
| --- | --- | --- |
| Основа | Nix + standalone Home Manager, закреплённый flake.lock, интеграция с Ubuntu, XDG, пользовательские шрифты | Все |
| Терминал | zsh, Oh My Zsh/agnoster, прежние алиасы, подключение Skotty при его наличии | Все |
| tmux | Текущий конфиг и тема; автообновление плагинов при запуске и перезагрузке включено | Все |
| Git и редактор | Git, Vim, приватный include для Git identity; EDITOR=vim | Все |
| CLI | curl, wget, ripgrep, fd, jq, htop, tree, unzip, zip, rsync, rclone, tealdeer, file, which | Все |
| Разработка | Node.js 22 с npm/corepack, Python 3, uv, GCC, make, CMake, pkg-config | Все |
| Шрифт | DejaVu Sans Mono Nerd Font | Все |
| VS Code | VS Code, 5 выбранных настроек интерфейса/редактора, 8 расширений из nixpkgs | Desktop, audio |
| Браузеры и почта | Firefox, Chromium, Thunderbird | Desktop, audio |
| Связь и API | Telegram, Discord, Zoom, Postman | Desktop, audio |
| Документы и заметки | Obsidian, LibreOffice | Desktop, audio |
| Графика и утилиты | GIMP, VLC, Flameshot, Remmina, Transmission, Pavucontrol | Desktop, audio |
| Звук | REAPER, Ardour, QjackCtl | Только audio |
| AI CLI | Codex CLI, Claude CLI | Опция my.ai.enable, выключена |

Профили: `lokehoke-minimal`, `lokehoke`, `lokehoke-audio`. Автоподключение к tmux включено по решению пользователя. GPU-интеграция пока выключена.

## Что нужно согласовать

1. Нужны ли сразу Firefox и Chromium, если основной браузер — Yandex Browser?
2. Какие GUI-программы действительно нужны: полный предложенный список или более компактный набор?
3. Включать ли Codex/Claude CLI по умолчанию и какие AI-расширения VS Code переносить?
4. Согласовано: сохранить zsh/agnoster и алиасы; включить автоподключение к tmux и автообновление его плагинов.
5. Оставлять ли Node/Python/компилятор глобально или вынести часть инструментов в devShell проектов?
6. Нужен ли аудиопрофиль на новом ноутбуке? Какие Vital/VST3/пресеты и лицензии должны в него войти?
7. Модель нового ноутбука и GPU — для настройки графической интеграции.

## Ещё не реализовано

- Все 13 исходных расширений VS Code: ID/версии сохранены в inventory; декларативно включены 8. Оставшиеся AI/вспомогательные расширения нужно разобрать отдельно.
- Прежние Vim-плагины и локальные изменения vim-colorschemes.
- Пользовательские настройки остальных GUI-приложений, выборочные GNOME/dconf-параметры, ассоциации файлов и автозапуск.
- Проектные Python/Jupyter/C/C++ окружения.
- Установка GitHub CLI через профиль Nix: сейчас gh установлен отдельно для публикации репозитория.
- ChatGPT/Codex Desktop, Claude Desktop, chats, Yandex Browser/Messenger/splitty: способ установки ещё не выбран.
- Vital, VST3, Electrum/Exodus и игровые программы: отдельный этап.

## Вне публичного репозитория

- SSH-хосты, токены, credentials, rclone.conf, ключи, сертификаты и кошельки.
- Браузерные профили, почта, заметки, AI-чаты, проекты, аудиозаписи и игровые сохранения — отдельный бэкап.
- Корпоративная регистрация, UEM, Skotty/TPM, VPN и внутренние CA — штатная процедура Ubuntu.
- Ядро, драйверы, LUKS, загрузчик, PAM, NetworkManager и VirtualBox/DKMS — системная часть Ubuntu.

Полный приватный отчёт ревизии остаётся в `~/migration-audit/REPORT.ru.txt`.
