FROM 192.168.1.240:5000/ubuntu

# Change the Ubuntu Mirror url
RUN sed -i 's/http:\/\/archive.ubuntu.com\/ubuntu\//http:\/\/archive.ubuntu.petiak.ir\/ubuntu\//' /etc/apt/sources.list

RUN apt-get update && apt-get install -y --no-install-recommends \
        git curl zsh \
        # tmux bash libncurses5-dev libncursesw5-dev openssh-client \
        python3 python3-pip \
        neovim bat fzf

WORKDIR /root/
# Fetch Rg and install it
RUN curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb && \
    dpkg -i ripgrep_11.0.2_amd64.deb

# Fetch nvm and run it
#RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.36.0/install.sh | bash && \
#    export NVM_DIR="$HOME/.nvm" && \
#    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
#    nvm install --lts
RUN apt-get install -y --no-install-recommends nodejs npm

# Fetch Oh My Zsh
RUN curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | zsh || true

# Fetch VimPlug
RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
# Copy config files
COPY .zshrc .zshrc
COPY .aliases .oh-my-zsh/custom/.aliases
COPY init.vim .config/nvim/init.vim
COPY coc-settings.json .config/nvim/coc-settings.json
# COPY .tmux.conf .tmux.conf

# Install Neovim Plugins
RUN nvim -c "PlugInstall" -c "qa"
RUN nvim -c "CocInstall \
    coc-angular \
    coc-css \
    coc-emmet \
    coc-eslint \
    coc-git \
    coc-html \
    coc-json \
    coc-markdownlint \
    coc-prettier \
    coc-python \
    coc-snippets \
    coc-stylelint \
    coc-tsserver" -c "qa"

CMD ["zsh"]

# Install Tmux Plugin Manager
# RUN git clone https://github.com/tmux-plugins/tpm .tmux/plugins/tpm && .tmux/plugins/tpm/bin/install_plugins

# Create a user called 'me'
# RUN useradd -ms /bin/zsh me

# Do everything from now in that users home directory
# WORKDIR /home/me
# ENV HOME /home/me

# Entrypoint script does switches u/g ID's and `chown`s everything
# COPY entrypoint.sh /bin/entrypoint.sh

# Default entrypoint, can be overridden
# ENTRYPOIN
# CMD []
