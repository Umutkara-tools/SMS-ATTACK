#!/bin/bash

# WGET  PAKET KONTROLÜ #

if [[ ! -a $PREFIX/bin/wget ]];then
	echo
	echo
	echo
	printf "\e[32m[✓]\e[97m WGET PAKETİ KURULUYOR"
	echo
	echo
	echo
	pkg install wget -y
fi

# SCRİPTS CONTROLS

if [[ ! -a files/update.sh ]];then
	echo
	echo
	echo
	printf "\e[32m[✓]\e[97m GEREKLİ SCRİPTLER KURULUYOR.."
	echo
	echo
	echo

	# UPDATE.SH ( GÜNCELLEME SCRİPTİ )

	wget -O files/update.sh  https://raw.githubusercontent.com/umutkara-tools/UMUT-KARA-TOOLS/master/files/update.sh

	# BOT_UMUTKARATOOLS ( BİLDİRİM SCRİPTİ )

	#wget -O $PREFIX/bin/bot_umutkaratools  https://raw.githubusercontent.com/umutkara-tools/UMUT-KARA-TOOLS/master/files/commands/bot_umutkaratools

	# LİNK-CREATE ( LİNK OLUŞTURMA SCRİPTİ )

	#wget -O $PREFIX/bin/link-create https://raw.githubusercontent.com/umutkara-tools/UMUT-KARA-TOOLS/master/files/commands/link-create

	#chmod 777 $PREFIX/bin/*

fi

if [[ $1 == update ]];then
	cd files
	bash update.sh update $2
	exit
fi


# CURL PAKET KONTROLÜ #

if [[ ! -a $PREFIX/bin/curl ]];then
	echo
	echo
	echo
	printf "\e[32m[✓]\e[97m CURL PAKETİ KURULUYOR"
	echo
	echo
	echo
	pkg install curl -y
fi

# PYTHON PAKET KONTROLÜ #

if [[ ! -a $PREFIX/bin/python ]];then
	echo
	echo
	echo
	printf "\e[32m[✓]\e[97m PYTHON KURULUYOR"
	echo
	echo
	echo
	pkg install python -y
fi

# PYTHON MODÜL KONTROLÜ #

if [[ -a files/requirements.txt ]];then
	echo
	echo
	echo
	printf "\e[32m[✓]\e[97m PYTHON MODÜLLERİ KURULUYOR"
	echo
	echo
	echo
	pip install -r files/requirements.txt
	mv files/requirements.txt files/.requirements.txt
fi

clear
cd files

##### UPDATE #####

bash update.sh
if [[ -a ../updates_infos ]];then
	rm ../updates_infos
	exit
fi

##################

if [[ $1 == "" || $1 == -h || $1 == --help ]];then
	clear
	bash banner.sh
	printf "\e[97m

	          +-+-+-+-+-+-+-+-+-+-+-+-+-+-+\e[1;33m
	                    |H|E|L|P|\e[0;97m
 	          +-+-+-+-+-+-+-+-+-+-+-+-+-+-+\e[97m


	\e[1;31m[ \e[1;4;97mSEÇENEKLER\e[0;1;31m ]\e[97m

	-n  --numara       \e[31m>>\e[32m NUMARA GİRİNİZ\e[97m

	-ms --moka_send    \e[31m>>\e[32m MOKA İLE RANDOM SMS GÖNDERTME\e[97m

	-m  --mesaj        \e[31m>>\e[32m BELİRLEDİĞİN BİR MESAJI GÖNDER\e[97m


	\e[31m[ \e[1;4;97mKULLANIM\e[0;1;31m ]\e[33m

	bash sms-attack.sh --numara +905555555555
	
	bash sms-attack.sh --numara +905555555555 --moka_send

	bash sms-attack.sh --numara +905555555555 --mesaj \"Merhaba Nasılsın\"
	"
	echo
	echo
	echo
	exit
fi
_progress() {
clear
bash banner.sh
progress () {
echo -ne "            \e[42;30mSending: [10%]\e[0;97m  [##.......................]\r"
sleep 0.5
echo -ne "            \e[42;30mSending: [25%]\e[0;97m  [#####....................]\r"
sleep 0.5
echo -ne "            \e[42;30mSending: [50%]\e[0;97m  [############.............]\r"
sleep 0.5
echo -ne "            \e[42;30mSending: [75%]\e[0;97m  [###################......]\r"
sleep 0.5
echo -ne "            \e[42;30mSending: [100%]\e[0;97m [#########################]\r"
echo -ne '\n'
}
echo
echo
echo
echo
echo
echo
progress
echo
echo
echo
echo
}
_close() {
printf "\e[33m
            +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+\e[97m

               BAĞLANTIYI KESMEK İÇİN\e[31m >> \e[97m[\e[31m CTRL Z \e[97m]\e[33m

            +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+\e[97m"
echo
echo
echo
}
if [[ $1 == -n || $1 == --numara ]];then
	if [[ -n $2 ]];then
		kontrol=$(printf "$2" |grep -o +)
		if [[ $kontrol == + ]];then
			if [[ $3 == -ms || $3 == --moka_send ]];then
				_progress
				_close
				bash moka_send.sh $2
			fi
			if [[ $3 == -m || $3 == --mesaj ]];then
				if [[ -n $4 ]];then
					_progress
					curl -s -X POST https://textbelt.com/text --data-urlencode phone="$2" --data-urlencode message="$4" -d key=textbelt > success
					control=$(cat success |grep -o false)
					if [[ -n $control ]];then
						control=$(cat success |grep -o "Test texts are temporarily disabled")
						if [[ -n $control ]];then
							echo
							echo
							echo
							printf "\e[33m
            +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+\e[97m

	    \e[31m[!]\e[97m ÖZEL SMS ATMA ÖZELLİĞİ TEXBELT SİTESİNDEN KAYNAKLI GEÇİCİ OLARAK DEVRE DIŞI.\e[33m.

            +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+\e[97m"
						       echo
						       echo
						       echo
						       rm success
						       exit
						fi
					fi

					control=$(cat success |grep -o false)
					if [[ -n $control ]];then
						control=$(cat success |grep -o "Only one test text message is allowed per day.")
						if [[ -n $control ]];then
							echo
							echo
							echo
							printf "\e[33m
            +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+\e[97m

	    \e[31m[!]\e[97m GÜNLÜK MESAJ GÖNDERME LİMİTİ BİTTİ
	    
	    \e[33m[*]\e[97m VPN KULLANARAK DENE HALA LİMİT BİTTİ DİYORSA
	    
	    EĞER BAŞKA NUMARA DENE.\e[33m.

            +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+\e[97m"
						       echo
						       echo
						       echo
						       rm success
						       exit
						fi
					fi
					control=$(cat success |grep -o false)
					if [[ -n $control ]];then
						control=$(cat success |grep -o "disabled for this country")
						if [[ -n $control ]];then
							echo
							echo
							echo
							printf "\e[33m
            +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+\e[97m


	    \e[31m[!]\e[97m MESAJ ATMA ÖZELLİĞİ TEXBELT SİTESİNDEN KAYNAKLI\n\n\t\tBU NUMARADA Kİ ÜLKE İÇİN ENGELLENMİŞTİR.\e[33m.


            +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+\e[97m"
						       echo
						       echo
						       echo
						       rm success
						       exit
						fi
					fi
					control=$(cat success |grep -o true)
					if [[ $control == true ]];then
						echo
						printf " \e[32m[✓]\e[97m MESAJ GÖNDERİLDİ \e[1;97m 
						$4\e[0m"
						echo
						rm success
						exit
					fi
				else
					echo
					echo
					echo
					printf "\e[31m[!]\e[97m MESAJ GİRİLMEDİ"
					echo
					echo
					echo
					exit
				fi
			else
				if [[ $3 == "" ]];then
					_progress
					_close
					python main.py $2
					exit
				fi
				echo
				echo
				echo
				printf "\e[31m[!]\e[97m HATALI SEÇİM"
				echo
				echo
				echo
				exit
			fi
		else
			echo
			echo
			echo
			printf "\e[31m[!]\e[97m HATALI NUMARA GİRDİNİZ"
			echo
			echo
			echo
			exit
		fi
	else
		echo
		echo
		echo
		printf "\e[31m[!]\e[97m NUMARA GİRİLMEDİ"
		echo
		echo
		echo
		exit

	fi
else
	if [[ $1 == -h ]];then
		exit
	fi
	echo
	echo
	echo
	printf "\e[31m[!]\e[97m HATALI SEÇİM"
	echo
	echo
	echo
	exit
fi
