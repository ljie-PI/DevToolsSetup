 @echo off

:: Function to check if scoop is installed
:check_scoop
where scoop >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo scoop could not be found!
    echo Please install scoop from https://scoop.sh
    echo Run the following command in PowerShell:
    echo Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
    echo irm get.scoop.sh ^| iex
    exit /b 1
)
echo scoop is installed!
exit /b 0

:: Function to install dependencies
:install_dependencies
scoop install neovim helix
scoop install llvm rust-analyzer lua-language-server python-lsp-server typescript-language-server
scoop install yazi 7zip jq poppler fd ripgrep fzf zoxide imagemagick
scoop bucket add nerd-fonts
scoop install nerd-fonts/Hack-NF nerd-fonts/Hack-NF-Mono
scoop install nerd-fonts/SourceCodePro-NF nerd-fonts/SourceCodePro-NF-Mono
scoop install nerd-fonts/FiraCode-NF nerd-fonts/FiraCode-NF-Mono
scoop install nerd-fonts/SpaceMono-NF nerd-fonts/SpaceMono-NF-Mono
exit /b 0

:: Function to setup yazi
:setup_yazi
if exist "%APPDATA%\yazi\config\yazi.toml" (
    echo yazi has already been setup
    exit /b 0
)
echo setting up yazi...

if not exist "%APPDATA%\yazi\config" (
    mkdir "%APPDATA%\yazi\config"
)

copy yazi\keymap.toml "%APPDATA%\yazi\config\keymap.toml"
copy yazi\yazi.toml "%APPDATA%\yazi\config\yazi.toml"
echo yazi has been setup successfully
exit /b 0

:: Function to setup neovim
:setup_neovim
if exist "%LOCALAPPDATA%\nvim" (
    echo neovim has already been setup
    exit /b 0
)
echo setting up neovim...

mkdir "%LOCALAPPDATA%\nvim"
xcopy /E /I neovim\* "%LOCALAPPDATA%\nvim\"
echo neovim has been setup successfully
exit /b 0

:: Function to setup helix
:setup_helix
if exist "%APPDATA%\helix" (
    echo helix has already been setup
    exit /b 0
)
echo setting up helix...

mkdir "%APPDATA%\helix"
xcopy /E /I helix\* "%APPDATA%\helix\"
echo helix has been setup successfully
exit /b 0

:: Function to setup wezterm
:setup_wezterm
if exist "%USERPROFILE%\.wezterm.lua" (
    echo wezterm has already been setup
    exit /b 0
)
echo setting up wezterm...

xcopy /E /I terminal\wezterm\wezterm.lua "%USERPROFILE%\.wezterm.lua"
echo wezterm has been setup successfully
exit /b 0

:: Function to setup windows-terminal
:setup_windows_terminal
:: Find the Windows Terminal package directory
set "TERMINAL_DIR="
for /d %%D in ("%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_*") do (
    set "TERMINAL_DIR=%%D\LocalState"
)

if "%TERMINAL_DIR%"=="" (
    :: Try finding Windows Terminal Preview if regular version not found
    for /d %%D in ("%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminalPreview_*") do (
        set "TERMINAL_DIR=%%D\LocalState"
    )
)

if "%TERMINAL_DIR%"=="" (
    echo Windows Terminal installation not found!
    echo Please install Windows Terminal from the Microsoft Store
    exit /b 1
)

if exist "%TERMINAL_DIR%\settings.json" (
    echo windows-terminal has already been setup
    exit /b 0
)
echo setting up windows-terminal...

:: Copy settings file
copy terminal\windows-terminal\settings.json "%TERMINAL_DIR%\settings.json"
echo windows-terminal has been setup successfully
exit /b 0

:: Main setup function
:setup
if "%~1"=="" (
    echo Please provide at least one parameter: yazi, neovim/nvim, helix, wezterm, windows-terminal, or all
    exit /b 1
)

:: Validate all parameters
:validate_params
for %%x in (%*) do (
    if /i "%%x"=="all" goto :continue_validate
    if /i "%%x"=="yazi" goto :continue_validate
    if /i "%%x"=="neovim" goto :continue_validate
    if /i "%%x"=="nvim" goto :continue_validate
    if /i "%%x"=="helix" goto :continue_validate
    if /i "%%x"=="wezterm" goto :continue_validate
    if /i "%%x"=="windows-terminal" goto :continue_validate
    echo Invalid parameter: %%x
    echo Valid parameters are: yazi, neovim/nvim, helix, wezterm, windows-terminal, all
    exit /b 1
    :continue_validate
)

:: Process parameters
for %%x in (%*) do (
    if /i "%%x"=="all" (
        call :setup_yazi
        call :setup_neovim
        call :setup_helix
        call :setup_wezterm
        call :setup_windows_terminal
        exit /b 0
    )
    if /i "%%x"=="yazi" call :setup_yazi
    if /i "%%x"=="neovim" call :setup_neovim
    if /i "%%x"=="nvim" call :setup_neovim
    if /i "%%x"=="helix" call :setup_helix
    if /i "%%x"=="wezterm" call :setup_wezterm
    if /i "%%x"=="windows-terminal" call :setup_windows_terminal
)
exit /b 0

:: Main entry point
call :check_scoop
if %ERRORLEVEL% NEQ 0 exit /b 1
call :setup %*