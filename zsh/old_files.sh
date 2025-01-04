awk '!seen[$0]++' <(nvim --headless -c 'oldfiles|q' 2>&1 | tr -d '' | cut -d ' ' -f 2- | grep "^\/Users")
# sed '1d' <(awk '!seen[$0]++' <(nvim --headless -c 'oldfiles|q' 2>&1 | tr -d '' | cut -d ' ' -f 2- | grep "^${PWD}*")) | head -n 3
