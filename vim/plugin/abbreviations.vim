" =======================================================================
" plugin/abbreviations.vim
" =======================================================================
scriptencoding utf-8

inoreabbrev :lod: ಠ_ಠ
inoreabbrev :idk: ¯\_(ツ)_/¯
inoreabbrev :wtf: ❨╯°□°❩╯︵┻━┻
inoreabbrev :wat: (☉_☉)

" https://github.com/junegunn/dotfiles/blob/aee195372bcfcf36c8c3db8245b1054d870f465d/vimrc#L650
inoreabbrev <expr> #!! "#!/usr/bin/env" . (empty(&filetype) ? '' : ' '.&filetype)
