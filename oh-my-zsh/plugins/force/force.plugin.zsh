
# force
alias ffl="force field list"
alias fsl="force sobject list"
alias fol="force sobject list"
alias fq="force query"

#
# force login wrapper
#
fl() {
  local password=`security -q find-generic-password -gl force 2>&1 | grep password | cut -d'"' -f2`
  local username='areese@engineyard.com'
  local instance='na5.salesforce.com'

  case $1 in
	  "dev"|"development" )
		  username='areese@engineyard.com.developer'
		  instance='test'
		  ;;
	  "acc"|"acceptance" )
		  username='areese@engineyard.com.acceptance'
		  instance='test'
		  ;;
	  "partner" )
		  username='areese@engineyard.com.partner'
		  instance='test'
		  ;;
  esac

  force login -u "${username}" -p "${password}" -i "${instance}" && echo "Logged in as $( force active )"
}


adoption() {
	force query "SELECT COUNT(Id) total, ${1} FROM ${2} ORDER BY COUNT(Id) DESC"
}
