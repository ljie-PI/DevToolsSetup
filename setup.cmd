 @echo off

:: Main entry point
call :setup %*
exit /b 0

:: Main setup function
:setup
if "%~1"=="" (
    call :setup_all
    exit /b 0
)
:: Process parameters
for %%x in (%*) do (
    if /i "%%x"=="all" (
        call :setup_all
    ) else if /i "%%x"=="yazi" (
        call :setup_yazi
    ) else if /i "%%x"=="neovim" (
        call :setup_neovim
    ) else if /i "%%x"=="nvim" (
        call :setup_neovim
    ) else if /i "%%x"=="helix" (
        call :setup_helix
    ) else if /i "%%x"=="wezterm" (
        call :setup_wezterm
    ) else if /i "%%x"=="windows-terminal" (
        call :setup_windows_terminal
    ) else (
        echo Invalid parameter: %%x
        echo Valid parameters are: yazi, neovim/nvim, helix, wezterm, windows-terminal, all
        exit /b 1
    )
)
exit /b 0

:: Function to setup all components
:setup_all
    call :install_packages neovim helix gzip cmake llvm rust-analyzer lua-language-server yazi 7zip jq poppler fd ripgrep fzf zoxide ghostscript imagemagik
    if %ERRORLEVEL% NEQ 0 exit /b 1

    call :install_fonts Hack-NF Hack-NF-Mono SourceCodePro-NF SourceCodePro-NF-Mono FiraCode-NF FiraCode-NF-Mono SpaceMono-NF SpaceMono-NF-Mono
    if %ERRORLEVEL% NEQ 0 exit /b 1

    call :setup_neovim 0
    call :setup_helix 0
    call :setup_yazi 0
    call :setup_wezterm 0
    call :setup_windows_terminal 0
    exit /b 0

:: Function to setup neovim
:setup_neovim
    if exist "%LOCALAPPDATA%\nvim" (
        echo neovim has already been setup
    ) else (
        echo setting up neovim...

        if not "%~1"=="0" (
            call :install_packages neovim gzip cmake ripgrep llvm rust-analyzer lua-language-server
            if %ERRORLEVEL% NEQ 0 exit /b 1

            call :install_fonts Hack-NF Hack-NF-Mono SourceCodePro-NF SourceCodePro-NF-Mono FiraCode-NF FiraCode-NF-Mono SpaceMono-NF SpaceMono-NF-Mono
            if %ERRORLEVEL% NEQ 0 exit /b 1
        )

        mkdir "%LOCALAPPDATA%\nvim"
        xcopy /E /I neovim\* "%LOCALAPPDATA%\nvim\"
        echo neovim has been setup successfully
    )
    exit /b 0

:: Function to setup helix
:setup_helix
    if exist "%APPDATA%\helix" (
        echo helix has already been setup
    ) else (
        echo setting up helix...

        if not "%~1"=="0" (
            call :install_packages helix llvm rust-analyzer lua-language-server
            if %ERRORLEVEL% NEQ 0 exit /b 1

            call :install_fonts Hack-NF Hack-NF-Mono SourceCodePro-NF SourceCodePro-NF-Mono FiraCode-NF FiraCode-NF-Mono SpaceMono-NF SpaceMono-NF-Mono
            if %ERRORLEVEL% NEQ 0 exit /b 1
        )

        mkdir "%APPDATA%\helix"
        xcopy /E /I helix\* "%APPDATA%\helix\"
        echo helix has been setup successfully
    )
    exit /b 0

:: Function to setup yazi
:setup_yazi
    if exist "%APPDATA%\yazi\config" (
        echo yazi has already been setup
    ) else (
        echo setting up yazi...

        if not "%~1"=="0" (
            call :install_packages yazi 7zip jq poppler fd ripgrep fzf zoxide ghostscript imagemagick
        )

        if not exist "%APPDATA%\yazi\config" (
            mkdir "%APPDATA%\yazi\config"
        )
        copy yazi\keymap.toml "%APPDATA%\yazi\config\keymap.toml"
        copy yazi\yazi.toml "%APPDATA%\yazi\config\yazi.toml"
        echo yazi has been setup successfully
    )
    exit /b 0

:: Function to setup wezterm
:setup_wezterm
    if exist "%USERPROFILE%\.wezterm.lua" (
        echo wezterm has already been setup
    ) else (
        echo setting up wezterm...

        if not "%~1"=="0" (
            call :install_fonts Hack-NF Hack-NF-Mono SourceCodePro-NF SourceCodePro-NF-Mono FiraCode-NF FiraCode-NF-Mono SpaceMono-NF SpaceMono-NF-Mono
            if %ERRORLEVEL% NEQ 0 exit /b 1
        )

        copy terminal\wezterm\wezterm.lua "%USERPROFILE%\.wezterm.lua"
        echo wezterm has been setup successfully
    )
    exit /b 0

:: Function to setup windows-terminal
:setup_windows_terminal
    :: Find the Windows Terminal package directory
    set "TERMINAL_DIR="
    for /d %%G in ("%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal*") do (
        set "TERMINAL_DIR=%%G\LocalState"
    )

    if "%TERMINAL_DIR%"=="" (
        echo Windows Terminal installation not found!
        echo Please install Windows Terminal from the Microsoft Store
    ) else (
        if exist "%TERMINAL_DIR%\settings.json" (
            echo windows-terminal has already been setup
        ) else (
            echo setting up windows-terminal...

            if not "%~1"=="0" (
                call :install_fonts Hack-NF Hack-NF-Mono SourceCodePro-NF SourceCodePro-NF-Mono FiraCode-NF FiraCode-NF-Mono SpaceMono-NF SpaceMono-NF-Mono
                if %ERRORLEVEL% NEQ 0 exit /b 1
            )

            :: Copy settings file
            copy terminal\windows-terminal\settings.json "%TERMINAL_DIR%\settings.json"
            echo windows-terminal has been setup successfully
        )
    )
    exit /b 0

:: Function to install packages
:install_packages
    call :check_scoop
    if %ERRORLEVEL% NEQ 0 exit /b 1

    setlocal enabledelayedexpansion
    for %%p in (%*) do (
        echo Checking %%p...
        scoop list | findstr /i /x "%%p.*" >nul 2>&1
        if !ERRORLEVEL! NEQ 0 (
            echo Installing %%p...
            call scoop install %%p
        ) else (
            echo %%p is already installed, skipping...
        )
    )
    endlocal
    exit /b 0

:: Function to install fonts
:install_fonts
    call :check_scoop
    if %ERRORLEVEL% NEQ 0 exit /b 1

    scoop bucket list | findstr /i /x "nerd-fonts.*" >nul 2>&1
    if %ERRORLEVEL% NEQ 0 (
        echo Adding nerd-fonts bucket...
        call scoop bucket add nerd-fonts
    )

    setlocal enabledelayedexpansion
    for %%f in (%*) do (
        echo Checking font %%f...
        scoop list | findstr /i /x "%%f.*" >nul 2>&1
        if !ERRORLEVEL! NEQ 0 (
            echo Installing font %%f...
            call scoop install nerd-fonts/%%f
        ) else (
            echo Font %%f is already installed, skipping...
        )
    )
    endlocal
    exit /b 0

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
    exit /b 0
