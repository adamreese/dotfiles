# zsh gnu untility
# -----------------------------------------------------------------------------

if (( $+commands[gwhoami] )); then
  _gnu_utility_cmds=(
    # Coreutils
    'base64' 'basename' 'chcon' 'chgrp' 'chmod' 'chown'
    'chroot' 'cksum' 'comm' 'cp' 'csplit' 'cut' 'date' 'dd' 'df'
    'dir' 'dircolors' 'dirname' 'du' 'env' 'expand' 'expr'
    'factor' 'false' 'fmt' 'fold' 'groups' 'head' 'hostid' 'id'
    'install' 'join' 'kill' 'link' 'ln' 'logname' 'ls' 'md5sum'
    'mkdir' 'mkfifo' 'mknod' 'mktemp' 'mv' 'nice' 'nl' 'nohup' 'nproc'
    'od' 'paste' 'pathchk' 'pinee' 'pr' 'printenv' 'ptx'
    'pwd' 'readlink' 'realpath' 'rm' 'rmdir' 'runcon' 'seq' 'sha1sum'
    'sha224sum' 'sha256sum' 'sha384sum' 'sha512sum' 'shred' 'shuf'
    'sleep' 'sort' 'split' 'stat' 'stty' 'sum' 'sync' 'tac' 'tail'
    'tee' 'test' 'timeout' 'touch' 'tr' 'true' 'truncate' 'tsort'
    'tty' 'uname' 'unexpand' 'uniq' 'unlink' 'uptime' 'users' 'vdir'
    'wc' 'who' 'whoami' 'yes'

    # The following utilities are not part of Coreutils but installed separately.

    # Binutils
    'addr2line' 'ar' 'c++filt' 'elfedit' 'nm' 'objcopy' 'objdump'
    'ranlib' 'readelf' 'size' 'strings' 'strip'

    # Findutils
    'find' 'locate' 'oldfind' 'updatedb' 'xargs'

    # Libtool
    'libtool' 'libtoolize'

    # Miscellaneous
    'getopt' 'grep' 'indent' 'sed' 'tar' 'time' 'units' 'which'
  )

  # Wrap GNU utilities in functions.
  for _gnu_utility_cmd in "${_gnu_utility_cmds[@]}"; do
    _gnu_utility_pcmd="g${_gnu_utility_cmd}"
    if (( ${+commands[${_gnu_utility_pcmd}]} )); then
      eval "
        function ${_gnu_utility_cmd} {
          '${commands[${_gnu_utility_pcmd}]}' \"\$@\"
        }
      "
    fi
  done

  unset _gnu_utility_{cmds,cmd,pcmd}
fi

# -----------------------------------------------------------------------------
# vim:ft=zsh
