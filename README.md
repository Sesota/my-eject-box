# My Eject Box  
My lovely eject box. I use it to have portable workspace configs  
## Instruction  
0. install these:  
    - git  
    - curl  
    - python3 and pip3  
    - nvm and nodejs and then `npm install -g @angular/cli  
    - fzf  
    - ripgrep  
    - zsh, oh-my-zsh, zsh-autocomplete, zsh-syntax-highlighting and powerlevel10k  
    - neovim and then neovim on pip3, vim-plug on neovim  
1. clone the repository in the home directory  
2. source the .aliases file in the repository  
    - `mkdir ~/.config/nvim` and `mkdir ~/.oh-my-zsh/custom` if needed  
3. execute `inject-all` to import the files into the system  
4. `source ~/.zshrc`  
5. Run `:PlugInstall` in neovim  
6. Run `:CocInstall coc-angular coc-css coc-emmet coc-eslint coc-fzf-preview coc-git coc-html coc-json coc-markdownlint coc-prettier coc-python coc-snippets coc-stylelint coc-tsserver`  
7. Enjoy I think...  

**Note**: Please make a script for this  
