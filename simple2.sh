title="Select Your Distro"
prompt="Pick an option:"
options=("UBUNTU" "CENTOS" "OTHER")

echo "$title"
PS3="$prompt "
select opt in "${options[@]}" "Quit"; do 

    case "$REPLY" in

    1 ) echo "You picked $opt which is option $REPLY"
    echo "daniel"
    wget https://downloads.tableau.com/esdalt/10.5.0/tableau-server-10-5-0.x86_64.rpm
                                                        ;;
    2 ) echo "You picked $opt which is option $REPLY";;
    3 ) echo "You picked $opt which is option $REPLY";;

    $(( ${#options[@]}+1 )) ) echo "Goodbye!"; break;;
    *) echo "Invalid option. Try another one.";continue;;

    esac

done

