
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

	if [[ -n $1 ]]; then
		case $1 in
			"dev"|"development" )
				username='areese@engineyard.com.developer'
				instance='test'
				;;
			"acc"|"acceptance" )
				username='areese@engineyard.com.acceptance'
				instance='test'
				;;
			*)
				username="areese@engineyard.com.${1}"
				instance='test'
				;;
		esac
	fi

	force login -u "${username}" -p "${password}" -i "${instance}" && echo "Logged in as $( force active )"
}

force_sso_id() {
	sso_id=${1:?"Error. You must supply a sso_id"}
	account_id=`force query "SELECT Id FROM EYAccount__c WHERE sso_id__c = '${sso_id}'" | grep a08`
	echo "account:${ey_account_id}"
}


adoption() {
	force query "SELECT COUNT(Id) total, ${1} FROM ${2} ORDER BY COUNT(Id) DESC"
}
