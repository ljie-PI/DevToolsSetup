#!/bin/bash

function check_brew() {
  if ! command -v brew &> /dev/null
  then
    echo "brew could not be found!"
    echo "Please install brew from https://brew.sh or https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/"
    exit 1
  fi
}

function setup_zsh() {
    if [ -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}" ]; then
        echo "zsh has already been setup"
        return
    fi
    echo "setting up zsh..."
    brew install zsh git

    # install ohmyzsh from mirrors
    cur_dir=$(pwd)
    cd /tmp
    git clone https://mirrors.tuna.tsinghua.edu.cn/git/ohmyzsh.git
    cd ohmyzsh/tools
    REMOTE=https://mirrors.tuna.tsinghua.edu.cn/git/ohmyzsh.git RUNZSH=no sh install.sh
    cd $cur_dir
    rm -rf /tmp/ohmyzsh

    git clone https://github.com/zsh-users/zsh-autosuggestions \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

    cp zsh/p10k.zsh ~/.p10k.zsh
    cp zsh/zshrc ~/.zshrc

    source ~/.zshrc
    echo "zsh has been setup successfully"
}

function setup_tmux() {
    if [ -f ~/.tmux.conf ]; then
        echo "tmux has already been setup"
        return
    fi
    echo "setting up tmux..."
    brew install tmux

    cp tmux/tmux.conf ~/.tmux.conf
    echo "tmux has been setup successfully"
}

function setup_yazi() {
    if [ -f ~/.config/yazi/yazi.toml ]; then
        echo "yazi has already been setup"
        return
    fi
    echo "setting up yazi..."
    brew install yazi ffmpegthumbnailer sevenzip jq poppler fd ripgrep fzf zoxide imagemagick

    # Create yazi config directory if it doesn't exist
    if [ ! -d ~/.config/yazi ]; then
        mkdir -p ~/.config/yazi
    fi

    # Copy configuration files
    cp yazi/keymap.toml ~/.config/yazi/keymap.toml
    cp yazi/yazi.toml ~/.config/yazi/yazi.toml
    echo "yazi has been setup successfully"
}

function setup_fonts() {
    echo "Setting up fonts..."

    cur_dir=$(pwd)
    cd ./fonts || { echo "Error: fonts directory not found"; return 1; }
    if [ -x "./install.sh" ]; then
        # Execute the install.sh script
        ./install.sh
    else
        echo "Error: install.sh not found or not executable in fonts directory"
    fi
    cd "$cur_dir"
    echo "fonts has been setup successfully"
}

function setup_neovim() {
    if [ -d ~/.config/nvim ]; then
        echo "neovim has already been setup"
        return
    fi
    echo "setting up neovim..."
    brew install neovim cmake ripgrep llvm rust-analyzer lua-language-server \
        bash-language-server python-lsp-server typescript-language-server

    # Create neovim config directory if it doesn't exist
    mkdir -p ~/.config/nvim

    # Copy configuration files
    cp -r neovim/* ~/.config/nvim/
    echo "neovim has been setup successfully"
}

function setup_helix() {
    if [ -d ~/.config/helix ]; then
        echo "helix has already been setup"
        return
    fi
    echo "setting up helix..."
    brew install helix llvm rust-analyzer lua-language-server \
        bash-language-server python-lsp-server typescript-language-server

    # Create helix config directory if it doesn't exist
    mkdir -p ~/.config/helix

    # Copy configuration files
    cp -r helix/* ~/.config/helix/
    echo "helix has been setup successfully"
}

function setup_wezterm() {
    if [ -d ~/.config/wezterm ]; then
        echo "wezterm has already been setup"
        return
    fi
    echo "setting up wezterm..."
    # Create wezterm config directory if it doesn't exist
    mkdir -p ~/.config/wezterm

    # Copy configuration files
    cp -r terminal/wezterm/* ~/.config/wezterm/
    echo "wezterm has been setup successfully"
}

function setup() {
    if [ $# -eq 0 ]; then
        echo "Please provide at least one parameter: zsh, tmux, yazi, fonts, neovim/nvim, helix, wezterm, or all"
        exit 1
    fi

    # First validate all parameters
    for param in "$@"; do
        case $param in
            "all"|"zsh"|"tmux"|"yazi"|"fonts"|"neovim"|"nvim"|"helix"|"wezterm")
                continue
                ;;
            *)
                echo "Invalid parameter: $param"
                echo "Valid parameters are: zsh, tmux, yazi, fonts, neovim/nvim, helix, wezterm, all"
                exit 1
                ;;
        esac
    done

    # If validation passes, proceed with setup
    for param in "$@"; do
        case $param in
            "all")
                setup_zsh
                setup_tmux
                setup_yazi
                setup_fonts
                setup_neovim
                setup_helix
                setup_wezterm
                return
                ;;
            "wezterm")
                setup_wezterm
                ;;
            "zsh")
                setup_zsh
                ;;
            "tmux")
                setup_tmux
                ;;
            "yazi")
                setup_yazi
                ;;
            "fonts")
                setup_fonts
                ;;
            "neovim"|"nvim")
                setup_neovim
                ;;
            "helix")
                setup_helix
                ;;
        esac
    done
}

# Main function
function main() {
    # Check if brew is installed
    check_brew

    # If no parameters provided, use 'all'
    if [ $# -eq 0 ]; then
        setup "all"
    else
        setup "$@"
    fi
}

# Call main function with all arguments
main "$@"
