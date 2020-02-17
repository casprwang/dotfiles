PATH=$PATH:/usr/local/bin
# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# mac port
export PATH=$PATH:/opt/local/bin

# Node
export PATH="$PATH:./node_modules/.bin"

# psql
export PATH="/Library/PostgreSQL/10/bin:$PATH"

export PATH=${PATH}:/usr/local/opt/gettext/bin

# haskell
export PATH="$HOME/.local/bin:$PATH"

# Node
export PATH="/usr/local/opt/node@10/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/node@10/lib"
export CPPFLAGS="-I/usr/local/opt/node@10/include"

# Linux nvim
if [[ "$(uname -s)" == "Linux" ]]; then
    echo 'in'
    alias nvim=~/Downloads/nvim.appimage
fi
