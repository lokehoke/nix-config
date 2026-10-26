{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nodejs_22
    (python3.withPackages (
      ps: with ps; [
        pip
        ipython
        jupyterlab
        notebook
        ipykernel
        flask
        python-dotenv
        jsonschema
        json5
        pygments
        qrcode
        pypng
        pyserial
        intelhex
        numpy
        pandas
        openpyxl
        xlsxwriter
        pillow
        pikepdf
        beautifulsoup4
        lxml
        requests
      ]
    ))
    uv
    pipx
    gcc
    gdb
    gnumake
    cmake
    pkg-config
  ];
  # Project-specific dependency versions can still be fixed in each project's devShell.
}
