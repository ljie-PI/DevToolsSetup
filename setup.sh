#!/bin/bash

function check_brew() {
  if ! command -v brew &> /dev/null
  then
    echo "brew could not be found!"
    echo "Please install brew from https://brew.sh or https://mirrors.tuna.tsinghua.edu.cn/help/homebrew/"
    exit 1
  fi

  echo "brew is installed!"
}

function install_dependencies() {
    brew install zsh tmux git \
        neovim helix \
        llvm rust-analyzer lua-language-server bash-language-server python-lsp-server typescript-language-server \
        yazi ffmpegthumbnailer sevenzip jq poppler fd ripgrep fzf zoxide imagemagick \
        font-symbols-only-nerd-font
    if [ $? -ne 0 ]; then
        exit 1
    fi
}

function setup_zsh() {
    if [ -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}" ]; then
        echo "zsh has already been setup"
        return
    fi
    echo "setting up zsh..."

    sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

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

    cp tmux/tmux.conf ~/.tmux.conf
    echo "tmux has been setup successfully"
}

function setup_yazi() {
    if [ -f ~/.config/yazi/yazi.toml ]; then
        echo "yazi has already been setup"
        return
    fi
    echo "setting up yazi..."

    # Create yazi config directory if it doesn't exist
    if [ ! -d ~/.config/yazi ]; then
        mkdir -p ~/.config/yazi
    fi

    # Copy configuration files
    cp yazi/keymap.toml ~/.config/yazi/keymap.toml
    cp yazi/yazi.toml ~/.config/yazi/yazi.toml
    echo "yazi has been setup successfully"
}

function setup_neovim() {
    if [ -d ~/.config/nvim ]; then
        echo "neovim has already been setup"
        return
    fi
    echo "setting up neovim..."

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
        echo "Please provide at least one parameter: zsh, tmux, yazi, neovim/nvim, helix, wezterm, or all"
        exit 1
    fi

    # First validate all parameters
    for param in "$@"; do
        case $param in
            "all"|"zsh"|"tmux"|"yazi"|"neovim"|"nvim"|"helix"|"wezterm")
                continue
                ;;
            *)
                echo "Invalid parameter: $param"
                echo "Valid parameters are: zsh, tmux, yazi, neovim/nvim, helix, wezterm, all"
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

    # Install dependencies
    install_dependencies

    # If no parameters provided, use 'all'
    if [ $# -eq 0 ]; then
        setup "all"
    else
        setup "$@"
    fi
}

# Call main function with all arguments
main "$@"