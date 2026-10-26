# Проверки 26 октября 2026

- Версии источников закреплены настоящим `nix flake lock`: nixpkgs `1f607aa79b6356ed45d3cd3c8079c196e79efa2c`, Home Manager `24f2190587513b9c2f73db112a17844ae912d965`.
- `scripts/check` завершился успешно: flake, minimal/desktop/audio и дополнительный вариант с AI CLI вычисляются без ошибок.
- `nix fmt` через `nixfmt-tree`: все Nix-файлы отформатированы.
- Окончательный `lokehoke-minimal.activationPackage` реально собран. Выход: `/nix/store/lf3cbah9svhaniswd3ks9k6kd4kjdlid-home-manager-generation`.
- Синтаксис сгенерированных `.zshrc` и `.zshenv` проверен через `zsh -n`. Переменная `YA_TOKEN` в них отсутствует. Git include ссылается на приватный runtime-файл.
- `git diff --check`, `bash -n scripts/check` и проверка распространённых шаблонов секретов прошли.

Использовался временный Nix в `/tmp`, без установки системного Nix и без активации Home Manager. Исходные пользовательские конфиги не заменены. Desktop/audio/AI пакеты прошли вычисление, но полностью не собирались и не запускались. Интеграция с GPU, keyring, VPN и корпоративной инфраструктурой требует проверки на целевом ноутбуке.
