#！/bin/bash
git config --global user.name      yi.guo 
git config --global user.email     yi.guo@ushow.media
git config --global ui.color       true
git config --global core.editor    vim
git config --global core.quotepath false
git config --global alias.st       status
git config --global alias.ci       commit
git config --global alias.co       checkout
git config --global alias.br       branch 

# git config --global diff.tool               diffmerge
# git config --global difftool.diffmerge.cmd  'diffmerge "$LOCAL" "$REMOTE"'
# git config --global merge.tool              diffmerge
# git config --global mergetool.diffmerge.cmd 'diffmerge --merge --result="$MERGED" "$LOCAL" "$(if test -f "$BASE"; then echo "$BASE"; else echo "$LOCAL"; fi)" "$REMOTE"'
# git config --global mergetool.diffmerge.trustExitCode true

# git config --global diff.tool               meld 
# git config --global difftool.diffmerge.cmd  'meld "$LOCAL" "$REMOTE"'
# git config --global merge.tool              meld

git config --global diff.tool               bc3
git config --global difftool.diffmerge.cmd  'bcompare "$LOCAL" "$REMOTE"'
git config --global merge.tool              bc3
git config --global mergetool.bc3.path      "/usr/bin/bcompare"

git config --global alias.unstage 'reset HEAD --'
git config --global alias.last    'log -1 HEAD'
git config --global alias.diffall 'git-diffall'
