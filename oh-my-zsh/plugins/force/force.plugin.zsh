
# force
alias ffl="force field list"
alias fsl="force sobject list"
alias fq="force query"

fl() {

  local password=`security -q find-generic-password -gl force 2>&1 | grep password | cut -d'"' -f2`
  local username='areese@engineyard.com'

  if (( $# == 0 )); then
    force login -u "${username}" -p "${password}"
  else
    force login -u "${username}.${1}" -p "${password}" -i test
  fi

  echo "Loggen in as $( force active )"
}
