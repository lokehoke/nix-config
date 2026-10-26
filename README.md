# nix-config

Программы и пользовательские настройки для Ubuntu/Linux `x86_64`, управляемые через Nix и Home Manager. Пользователь и домашний каталог заданы в `home/lokehoke.nix`.

## Профили

| Профиль | Что устанавливается |
| --- | --- |
| `lokehoke-minimal` | Оболочка, tmux, Vim, консольные утилиты, Python, JavaScript, C++, Claude Code и Codex CLI |
| `lokehoke` | Всё из minimal, VS Code, графические приложения и приложения по умолчанию |

## Программы

| Назначение | Программы |
| --- | --- |
| Терминал | Zsh, Oh My Zsh, tmux, DejaVu Sans Mono Nerd Font |
| Редактор | Vim; плагины vim-eunuch, vim-surround, nginx.vim, vim-colorschemes, vim-matlab, Vundle |
| Git | Git, GitHub CLI |
| Python | Python 3, pip, pipx, uv, IPython, JupyterLab, Notebook, ipykernel |
| JavaScript | Node.js 22 и npm |
| C/C++ | GCC/G++, GDB, GNU Make, CMake, pkg-config |
| IDE | VS Code; Python, Pylance, Python Debugger, Python Environments, C/C++, C/C++ Themes, Remote SSH, Remote SSH Editing Configuration Files, Remote Explorer, Jupyter Keymap, Claude Code, Codex |
| AI | Claude Code и Codex CLI; Claude Desktop и Codex Desktop в полном профиле |
| Общение | Telegram, Discord, Zoom |
| Работа | Postman, Obsidian, LibreOffice |
| Изображения и снимки экрана | GIMP, Eye of GNOME, Flameshot |
| Видео и музыка | VLC, Totem, Rhythmbox, Pavucontrol |
| Файлы и документы | Nautilus, File Roller, Evince, Gedit |
| Удалённый доступ и загрузки | Remmina, Transmission |

Консольные утилиты:

- Bash, coreutils, diffutils, findutils, grep, sed, awk, file, which, less, bc.
- curl, wget, OpenSSH, GnuPG, GnuTLS, NSS tools, OpenSC, links2.
- ripgrep, fd, jq, htop, tree, tealdeer, fastfetch, F3.
- unzip, zip, gzip, tar, xz, rsync, rclone.
- Tesseract, Ghostscript, esptool, protontricks.
- Команда `neofetch` запускает fastfetch.

Библиотеки Python: Flask, python-dotenv, jsonschema, json5, Pygments, qrcode, pypng, pyserial, intelhex, NumPy, pandas, openpyxl, XlsxWriter, Pillow, pikepdf, Beautiful Soup, lxml, requests.

## Настройки

- **Zsh:** тема agnoster, плагин Git, текущие алиасы и чтение `~/.config/private/shell.zsh`.
- **tmux:** текущие оформление и сочетания клавиш, автоматическое подключение к сессии `home`, обновление плагинов при запуске и перезагрузке конфигурации.
- **Vim:** все шесть плагинов на закреплённых коммитах, локальные изменения vim-colorschemes, подсветка синтаксиса, filetype-плагины и отступы, прежние настройки редактирования. Vim выбран редактором по умолчанию.
- **Git:** ветка `main` по умолчанию, редактор Vim, авторизация GitHub через `gh`, дополнительные настройки из `~/.config/private/git.conf`.
- **VS Code:** боковая панель справа, панель действий снизу, без стартовой страницы, удаление пробелов в конце строк, отображение завершающей пустой строки и панель Claude Code.
- **Claude и Codex:** тёмная тема Claude и текущие настройки модели Codex для новой установки, обработчики ссылок приложений, текущий параметр запуска Codex Desktop `--disable-gpu-compositing`. Существующие файлы настроек сохраняются.
- **Приложения по умолчанию:** 435 ассоциаций файлов и URI; JSON открывается в Gedit, WebP — в Eye of GNOME. Обработчики HTTP/HTTPS остаются на стороне Ubuntu.
- **Окружение:** `~/.local/bin` в PATH, fontconfig, команды `nix-command` и `flakes`.

Версии зависимостей закреплены в `flake.lock`, источники дополнительных пакетов — в `pkgs/` и `inventory/`. Перечень приватных настроек и данных Claude/Codex для отдельного переноса находится в `inventory/private-transfer.json`.
