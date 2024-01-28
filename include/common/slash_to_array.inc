# This function creates an array of a *nix path
# Example: /home/user/bin becomes an array of ( home user bin )

function slash_to_array () {

	sta=( $( echo ${1} | sed -e "s/\//\ /g" ) )
	# return ${sta}

}