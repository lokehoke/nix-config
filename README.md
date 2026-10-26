# nix-config

Конфигурация Ubuntu + standalone Home Manager для переноса на новый ноутбук. Структура вдохновлена [BugLight/nixos-config](https://github.com/BugLight/nixos-config). Изменения находятся в PR для ревью; к текущему компьютеру они не применяются.

## Согласованный состав

- zsh/Oh My Zsh/agnoster и прежние алиасы; автоматическое подключение к tmux `home` и обновления его плагинов включены.
- Все шесть обнаруженных Vim-плагинов на исходных коммитах, включая Vundle; локальные изменения vim-colorschemes сохранены. Личного `.vimrc` не было: переносятся обычные настройки Vim.
- Консольные утилиты, GitHub CLI, Python/Jupyter, Node.js 22, GCC/GDB, make/CMake.
- VS Code через Nix: исходные расширения кроме Roo Code; AI — только Claude Code и Codex.
- Telegram, Discord, Zoom, Postman, Obsidian, LibreOffice, GIMP, VLC, Flameshot, Remmina, Transmission, Pavucontrol.
- GNOME-приложения для сохранения текущих обработчиков файлов: Evince, Eye of GNOME, Totem, Gedit, File Roller, Nautilus.
- Claude Code и Codex CLI во всех профилях; официальные Linux desktop-приложения Claude и Codex в desktop-профиле.
- Firefox, Chromium, Яндекс Браузер, Thunderbird, аудиопроизводство и корпоративные инструменты исключены по решению пользователя.

Подробно: [состав](docs/scope.md), [миграция личных данных](docs/migration.md), [проверки](docs/validation.md).

Neofetch удалён из текущего nixpkgs как неподдерживаемый: вместо него устанавливается fastfetch, а прежняя команда `neofetch` сохранена как совместимый запуск fastfetch.

## Профили

| Профиль | Состав |
| --- | --- |
| `lokehoke-minimal` | Shell, tmux, Vim, CLI, Python/JS/C++, Claude/Codex CLI |
| `lokehoke` | Minimal + VS Code, desktop-программы, Claude/Codex Desktop и MIME-ассоциации |

Целевая платформа — Ubuntu/Linux `x86_64`. Имя пользователя и HOME задаются в `home/lokehoke.nix`. Модель ноутбука не зафиксирована; GPU-интеграция выключена до настройки аппаратуры. Для ARM нужны отдельные источники desktop-пакетов и повторная проверка.

## Проверка и применение после ревью

Сначала установи Nix по [официальной инструкции](https://nixos.org/download/). Для первого запуска нужны flakes и nix-command:

```sh
export NIX_CONFIG='experimental-features = nix-command flakes'
git clone --branch review/ubuntu-home-manager https://github.com/lokehoke/nix-config.git ~/nix-config
cd ~/nix-config
./scripts/check
nix build .#homeConfigurations.lokehoke-minimal.activationPackage
```

Сборка создаёт `result` и не применяет настройки. Сгенерированные файлы находятся в `result/home-files`. Перед первой активацией сохрани текущие конфиги и закрой приложения. Home Manager использует ссылки в Nix store; редактировать настройки нужно в этом репозитории.

```sh
# Только после просмотра результата. Выбирай новый суффикс для каждого применения.
nix run .#home-manager -- switch --flake .#lokehoke-minimal -b before-nix-2026-10-26
# После проверки CLI можно выбрать полный профиль:
home-manager switch --flake .#lokehoke
```

CLI Home Manager и профили используют `flake.lock`. Не удаляй старые конфиги автоматически. Login shell меняется отдельно через `/etc/shells` и `chsh` после проверки zsh. Для графики на новом ноутбуке настрой genericLinux GPU/nixGL с учётом драйвера хоста.

## Claude и Codex

CLI устанавливаются из nixpkgs; desktop-пакеты упакованы из официальных Linux `.deb` с закреплёнными URL, версиями и SHA256: [источники](inventory/ai-desktop-sources.json). Для совместимости desktop используется FHS-окружение. Эти обёртки нужно проверить на целевом ноутбуке: интеграция с GPU, D-Bus, keyring и sandbox зависит от Ubuntu. Обход sandbox автоматически не включается.

На новой установке создаются только переносимые настройки: тёмная тема Claude и нынешние model/reasoning preferences Codex. Существующие файлы не перезаписываются, настройки остаются изменяемыми для самих приложений.

Полный приватный перенос — `.codex`, `.claude`, desktop-профили, skills, rules, hooks, MCP, история, базы, изображения и авторизация. В репозитории находится только [перечень путей](inventory/private-transfer.json); их содержимое не публикуется и не копируется в Nix store. Перед копированием нужно закрыть приложения; авторизацию на новом устройстве может потребоваться подтвердить заново.

## Приложения по умолчанию

Сохраняются эффективные обработчики документов, изображений, видео, аудио, архивов, каталогов и URI приложений. Snap-ID Telegram/Zoom заменены на Nix-ID. HTTP/HTTPS и defaults графических браузеров не задаются. JSON раньше открывал Firefox; после его исключения используется уже существовавшая ассоциация Gedit. WebP вместо удалённого Яндекс Браузера открывается в Eye of GNOME. Список исключений: [inventory/default-applications.json](inventory/default-applications.json).

## Приватные файлы

Shell читает `~/.config/private/shell.zsh` во время запуска, Git — `~/.config/private/git.conf`. Они не входят в репозиторий/store. Имя/email Git и секреты восстанавливаются отдельно; файлы держать с правами `0600`, каталог — `0700`. Приватные SSH-хосты также не публикуются.

## Разработка

```sh
nix develop
nix fmt
./scripts/check
nix build .#vim-plugins .#vim
```

Новые файлы нужно `git add` до проверки Git-backed flake. Обновление зависимостей — отдельный `nix flake update` с проверками. Проверка шаблонов секретов вспомогательная и не заменяет просмотр diff.

Tmux основан на [gpakosz/.tmux](https://github.com/gpakosz/.tmux), его MIT-лицензия сохранена. Vim-плагины загружаются из исходных репозиториев вместе с их лицензиями; коммиты и хэши находятся в [inventory/vim-plugins.json](inventory/vim-plugins.json).
