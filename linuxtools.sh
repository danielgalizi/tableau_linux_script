#!/bin/bash

server_debian="https://downloads.tableau.com/esdalt/10.5.1/tableau-server-10-5-1_amd64.deb"
#"https://downloads.tableau.com/esdalt/10.5.0/tableau-server-10-5-0_amd64.deb"

server_rhel="https://downloads.tableau.com/esdalt/10.5.1/tableau-server-10-5-1.x86_64.rpm"
#"https://downloads.tableau.com/esdalt/10.5.0/tableau-server-10-5-0.x86_64.rpm"

md5_debian="6F87C8D625327712474A1FFE12A04C02"
md5_rhel="2F373B8427329BD28398A143396C5931"

installer_debian="https://github.com/tableau/server-install-script-samples/raw/master/linux/automated-installer/packages/tableau-server-automated-installer-10-5-0_all.deb"

installer_rhel="https://github.com/tableau/server-install-script-samples/raw/master/linux/automated-installer/packages/tableau-server-automated-installer-10-5-0.noarch.rpm"

config_json="https://raw.githubusercontent.com/tableau/server-install-script-samples/master/linux/automated-installer/config.json"
reg_templ="https://raw.githubusercontent.com/tableau/server-install-script-samples/master/linux/automated-installer/reg_templ.json"
secrets_file="https://raw.githubusercontent.com/tableau/server-install-script-samples/master/linux/automated-installer/secrets"



echo $'\n'
echo "Welcome to the Interactive Tableau Server Installer."
echo $'\n'
echo "What do you wanna do?"
echo $'\n'

prompt="Pick an option:"
options=("Download Tableau Server" "Download Automated Install Script" "Generate Template Files" "Install Tableau Server Using Automated Install" "Verify Hardware Setup")   
PS3="$prompt "

select opt in "${options[@]}" "Quit"; do 

    case "$REPLY" in

    1 ) echo "$opt"
        echo $'\n'
        echo "Select Your Flavor"
        echo $'\n'
        prompt="Pick an option:"
        options=("Debian" "RHEL")   
        PS3="$prompt "

            select os in "${options[@]}" "Quit"; do 

            case "$REPLY" in

            1 ) echo "You picked $opt and $os"; 
                echo "Initiating Download..."
                wget -c $server_debian
                md5_debian=$(echo "$md5_debian" | tr '[:lower:]' '[:upper:]')
                md5=($(md5sum ${server_debian##*/}))
                md5=$(echo "$md5" | tr '[:lower:]' '[:upper:]')
                #echo $md5 
                #echo $md5_debian
                
                if [ $md5  == $md5_debian ]
                then 
                echo -e "\e[42mFile Verified! Everything is fine."
                echo -e "\e[49m"
                else 
                echo -e "\e[41mCorrupted File! Download it again."
                echo -e "\e[49m"
                fi   
                break;;
            2 ) echo "You picked $opt and $os"; 
                echo "Initiating Download..."
                wget -c $server_rhel
                md5_debian=$(echo "$md5_rhel" | tr '[:lower:]' '[:upper:]')
                md5=($(md5sum ${server_rhel##*/}))
                md5=$(echo "$md5" | tr '[:lower:]' '[:upper:]')
                #echo $md5 
                #echo $md5_rhel
                
                if [ $md5  == $md5_rhel ]
                then 
                echo -e "\e[42mFile Verified! Everything is fine."
                echo -e "\e[49m"
                else 
                echo -e "\e[41mCorrupted File! Download it again."
                echo -e "\e[49m"
                fi   
                break;;
            $(( ${#options[@]}+1 )) ) echo "Goodbye!"; break;;
            *) echo "Invalid option. Try another one.";continue;;
            esac

            done
            break;;
    2 ) echo "$opt"
        echo $'\n'
        echo "Select Your OS"
        echo $'\n'
        prompt="Pick an option:"
        options=("Ubuntu" "CentOs")   
        PS3="$prompt "

            select os in "${options[@]}" "Quit"; do 

            case "$REPLY" in

            1 ) echo "You picked $opt and $os"; 
                echo "Initiating Download..."
                wget -c $installer_debian
                break;;

            2 ) echo "You picked $opt and $os"; 
                echo "Initiating Download..."
                wget -c $installer_rhel
                break;;
            $(( ${#options[@]}+1 )) ) echo "Goodbye!"; break;;
            *) echo "Invalid option. Try another one.";continue;;
            esac

            done
            break;;
    3 ) echo "$opt"
        #read -p "Press any key..."
        wget -c $config_json
        wget -c $reg_templ
        wget -c $secrets_file
        
        break;;

    4 ) echo "$opt"
        echo $'\n'
        echo "Select Your OS"
        echo $'\n'
        prompt="Pick an option:"
        options=("Ubuntu" "CentOs")   
        PS3="$prompt "

            select os in "${options[@]}" "Quit"; do 

            case "$REPLY" in

            1 ) echo "You picked $opt and $os"; break;;
            2 ) echo "You picked $opt and $os"; break;;
            $(( ${#options[@]}+1 )) ) echo "Goodbye!"; break;;
            *) echo "Invalid option. Try another one.";continue;;
            esac

            done
            break;;

      5 ) echo "$opt"
        echo $'\n'
        echo "CPU Info:"
        echo $'\n'
        lscpu
        echo $'\n'
        echo "Memory Info:"
        echo $'\n'
        free –h
        echo $'\n'
        echo "Disk Info:"
        echo $'\n'
        df -h

            break;;

    $(( ${#options[@]}+1 )) ) echo "Goodbye!"; break;;
    *) echo "Invalid option. Try another one.";continue;;

    esac

done
