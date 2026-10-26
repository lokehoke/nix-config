# nix-config

Личная конфигурация Ubuntu + standalone Home Manager, собранная по ревизии ноутбука 26 октября 2026 года. Структура вдохновлена [BugLight/nixos-config](https://github.com/BugLight/nixos-config); модули NixOS здесь не используются.

Статус: предложение для ревью, состав пакетов и значения по умолчанию ещё не утверждены. [Полный список, вопросы и незавершённые части](docs/scope.md).

## Профили

| Профиль | Что устанавливает |
| --- | --- |
| `lokehoke-minimal` | zsh/agnoster, текущий tmux, Git, Vim, Node 22, Python, компилятор и CLI |
| `lokehoke` | minimal + VS Code, браузеры, почта, мессенджеры, офис, графика, Obsidian |
| `lokehoke-audio` | desktop + REAPER, Ardour, QjackCtl |

`my.ai.enable = true;` дополнительно включает Codex CLI и Claude CLI. Авторизация остаётся вне репозитория. `my.shell.autoTmux = true;` включает автоматическое подключение к сессии tmux `home` в интерактивном терминале; эта настройка включена во всех профилях.

Поддерживается `x86_64-linux`. Для другого имени пользователя, домашнего каталога или ARM нужно изменить `home/lokehoke.nix` и `system` в `flake.nix`. `home.stateVersion` — исходная версия совместимости Home Manager; при обновлениях её не повышают автоматически.

## Проверка и установка

Сначала установи Nix по [официальной инструкции](https://nixos.org/download/), с поддержкой flakes и nix-command. Эти возможности нужны ещё до первой активации:

```sh
export NIX_CONFIG='experimental-features = nix-command flakes'
git clone https://github.com/lokehoke/nix-config.git ~/nix-config
cd ~/nix-config
./scripts/check
nix build .#homeConfigurations.lokehoke-minimal.activationPackage
```

Сборка создаёт `result`, но не меняет домашние конфиги. Проверить сгенерированные файлы можно в `result/home-files`. Перед первой активацией сохрани текущие конфиги и закрой приложения. На старом ноутбуке есть существующие `.zshrc`, `.tmux.conf`, `.tmux.conf.local`, настройки VS Code: Home Manager не должен молча затирать их.

```sh
# После просмотра результата; суффикс должен быть новым для каждого применения.
nix run .#home-manager -- \
  switch --flake .#lokehoke-minimal -b before-nix-2026-10-26
```

Далее используй установленную команду `home-manager switch --flake .#lokehoke`. Команда `nix run .#home-manager` и сами профили используют версии из `flake.lock`. Не используй `--force` и не удаляй старые конфиги автоматически. Home Manager не меняет login shell: при необходимости отдельно добавь путь к Nix zsh в `/etc/shells` и выбери его через `chsh` после проверки.

Графические программы на Ubuntu требуют проверки интеграции с GPU/GL, keyring и desktop portals. `targets.genericLinux` включает базовую интеграцию. Опция `targets.genericLinux.gpu.enable` явно выключена до выбора нового ноутбука: настрой nixGL или genericLinux GPU по его аппаратуре и документации выбранной версии Home Manager. Для NVIDIA версия библиотек должна соответствовать драйверу хоста.

Настройки редактируются в этом репозитории и применяются через Home Manager; сгенерированные файлы в HOME являются ссылками в Nix store.

## Секреты и личные данные

Не копировать сюда ревизию из `~/migration-audit`, браузерные профили, `.ssh`, кошельки, историю, `.codex` или конфиги рабочих CLI. Путь в `home.file.source` попадает в Nix store; даже игнорируемый Git файл нельзя подключать таким способом, если в нём есть секреты.

Shell читает `~/.config/private/shell.zsh` во время запуска, Git — `~/.config/private/git.conf`. Файлы создаются отдельно и не входят в store. Для Git задай там `user.name` и `user.email`; для секретных файлов используй права `0600`, для каталога — `0700`. SSH-конфиг пока остаётся внешним. Skotty вызывается, только когда уже установлен штатным способом.

Подробности оставшихся задач: [docs/migration.md](docs/migration.md). Исходные ID и версии расширений: [inventory/vscode-extensions.json](inventory/vscode-extensions.json). Перенесены только выбранные безопасные настройки редактора; разрешения AI-агентов и MCP не импортированы.

## Разработка

```sh
nix develop
nix fmt
./scripts/check
nix build .#homeConfigurations.lokehoke-minimal.activationPackage
```

При добавлении файлов сначала `git add`, иначе Git-backed flake их не видит. `scripts/check-secrets.py` ищет несколько распространённых шаблонов; это вспомогательная проверка, а не гарантия отсутствия секретов. Обновление зависимостей — отдельный `nix flake update` с повторной проверкой и сборкой.

Конфиг tmux взят с текущего ноутбука, основан на [gpakosz/.tmux](https://github.com/gpakosz/.tmux). Его исходная лицензия сохранена в `config/tmux/LICENSE.MIT`. Автообновление плагинов tmux включено при запуске и перезагрузке конфига.
