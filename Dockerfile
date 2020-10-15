FROM 192.168.1.240:5000/alpine

WORKDIR ~/
RUN apk add -U --no-cache \
        git curl zsh \
        tmux bash ncurses openssh-client \
        python3 py-pip nvm \
        neovim bat fzf ripgrep \

RUN nvm install --lts

# Fetch Oh My Zsh
RUN curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | zsh || true

# Fetch VimPlug
RUN curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Copy config files
COPY .zshrc .zshrc
COPY .aliases .oh-my-zsh/custom/.aliases
COPY init.vim .config/nvim/init.vim
COPY coc-settings.json .config/nvim/coc-settings.json
COPY .tmux.conf .tmux.conf

# Install Neovim Plugins
RUN nvim +PlugInstall +qall >> /dev/null
RUN nvim +CocInstall \
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
    coc-tsserver >> /dev/null

# Install Tmux Plugin Manager
RUN git clone https://github.com/tmux-plugins/tpm .tmux/plugins/tpm

# Install plugins
RUN .tmux/plugins/tpm/bin/install_plugins

# Create a user called 'me'
RUN useradd -ms /bin/zsh me

# Do everything from now in that users home directory
WORKDIR /home/me
ENV HOME /home/me

# Entrypoint script does switches u/g ID's and `chown`s everything
COPY entrypoint.sh /bin/entrypoint.sh

# Default entrypoint, can be overridden
CMD ["/bin/entrypoint.sh"]
