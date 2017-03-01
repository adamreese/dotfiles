# ------------------------------------------------------------------------------
# zlogin
# ------------------------------------------------------------------------------

(
  # Function to determine the need of a zcompile. If the .zwc file
  # does not exist, or the base file is newer, we need to compile.
  # These jobs are asynchronous, and will not impact the interactive shell
  zcompare() {
    if [[ -s ${1} && ( ! -s ${1}.zwc || ${1} -nt ${1}.zwc) ]]; then
      zcompile ${1}
    fi
  }

  setopt EXTENDED_GLOB

  # zcompile the completion cache; siginificant speedup.
  for file in ${ZDOTDIR:-${HOME}}/.zcomp^(*.zwc)(.); do
    zcompare ${file}
  done

  # zcompile .zshrc
  zcompare ${ZDOTDIR:-${HOME}}/.zshrc

  # zcompile all .zsh files in the custom module
  for file in ${ZSH}/*.zsh(.); do
    zcompare ${file}
  done

  # zcompile all autoloaded functions
  for file in ${ZSH}/{completion,functions}/^(*.zwc)(.); do
    zcompare ${file}
  done

  # zcompile all modules
  for file in ${ZSH}/modules/**/*.zsh(.); do
    zcompare ${file}
  done

) &!


# ------------------------------------------------------------------------------
# vi:ft=zsh
