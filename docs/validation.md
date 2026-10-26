# Проверки 26 октября 2026

## Источники и статические проверки

- nixpkgs `1f607aa79b6356ed45d3cd3c8079c196e79efa2c`, Home Manager `24f2190587513b9c2f73db112a17844ae912d965`; зависимости закреплены в flake.lock.
- `scripts/check` успешно проверил оба итоговых профиля и собственные пакеты.
- Все 6 исходных Vim-плагинов собраны на прежних коммитах. Снятые executable-биты двух scripts в vim-colorschemes проверены в результате сборки.
- VSIX Codex и C++ themes проверены как ZIP-пакеты с ожидаемыми publisher/name/version и закреплены по SHA256.
- JSON-манифесты, форматирование Nix, git diff и проверка распространённых шаблонов секретов прошли.
- Считаны текущие обработчики 449 MIME-типов; перенесены 435 ассоциаций. Исключения записаны в inventory/default-applications.json.

## Реальные сборки

Собраны оба официальных desktop-пакета в FHS-обёртках и итоговый CLI activationPackage. Их выходы при проверке:

- Codex/ChatGPT Desktop: `/nix/store/gsb2ahnm23dbnaphaicihx83hbiw86xf-chatgpt`.
- Claude Desktop: `/nix/store/332wxff4i5v0kmi4s9wcfaz1r4xa4xqa-claude-desktop`.
- CLI-профиль: `/nix/store/p7qd4b4z7nbagrhzr8vn549rwyvmx1zz-home-manager-generation`.

Установщики desktop и бинарник Claude CLI проверены по исходным SHA256. Распаковка `.deb` не переносит привилегированные ownership/mode-биты в Nix store. Флаги отключения sandbox не добавлялись. Существующий пользовательский флаг Codex `--disable-gpu-compositing` сохранён отдельно в его desktop entry.

## Проверки запуска CLI

В окружении собранного профиля успешно выполнены:

- Python 3.13.15: импорт numpy, pandas, JupyterLab, Flask, pikepdf, pyserial и intelhex.
- Node.js 22.23.4: запуск программы.
- GCC/G++ 15.3.0: компиляция и запуск C++ программы.
- Vim: загрузка vim-surround и команд vim-eunuch; все 6 пакетов присутствуют в сборке.
- Codex CLI 0.146.0 и Claude Code 2.1.223: команды вывода версии.
- Синтаксис сгенерированных `.zshrc` и `.zshenv`.
- Desktop entries Claude/Codex: наличие и корректные пути Exec к собранным обёрткам.

## Границы

Проверки выполнены временным Nix в /tmp. Системный Nix не установлен, Home Manager не активирован, исходные пользовательские конфиги не заменены. Графические приложения не запускались; GPU/portal/keyring и sandbox-интеграцию нужно проверить на целевом ноутбуке. Полный набор стандартных GUI-приложений прошёл вычисление, но не собирался и не запускался целиком. Бэкап истории, токенов и других приватных данных не создавался.
