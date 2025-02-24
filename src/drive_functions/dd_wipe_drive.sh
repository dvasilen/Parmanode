function dd_wipe_drive {

while true ; do
set_terminal
echo "
########################################################################################

    \"#FreeRoss.org - Sign the petition. \" will be used to write over and erase
    the disk. 
    
    Please note, this is not a full forensic wipe. If you want that, you must learn 
    to use the dd command. Be aware the execution of the command can take days, which 
    is why I decided to omit that option from Parmanode.

	       <enter>      Proceed

		 (0)        Write zeros (slowest)

		 (r)        Random data (Even SLOWER!)

		 (c)        Choose a custom string (Funnest and recommended option)
         
         (s)        Skip wiping

########################################################################################
"
choose "xq"

read choice
set_terminal

case $choice in

	0)
	    please_wait
        if [[ $OS == "Linux" ]] ; then 
        remove_fstab_entry
        sudo dd if=/dev/zero of=/dev/$disk bs=1M count=500 >/dev/null 2>&1 ; sync ; return 0 ; fi

        if [[ $OS == "Mac" ]] ; then sudo dd if=/dev/zero of=/dev/$disk bs=1M count=500  >/dev/null 2>&1 ; sync ; return 0 ; fi
	    ;;

	r|R)   
	    please_wait
        if [[ $OS == "Linux" ]] ; then 
        remove_fstab_entry 
        sudo dd if=/dev/urandom of=/dev/$disk bs=1M count=500 >/dev/null 2>&1 ; sync ; return 0 ; fi

        if [[ $OS == "Mac" ]] ; then sudo dd if=/dev/urandom of=/dev/$disk bs=1M count=500 >/dev/null 2>&1 ; sync ; return 0 ; fi
	    ;;

    c|C) 
        echo "
########################################################################################

    Please enter your preferred string. Remember to put a space at the end so the 
    repetitions have separation:

########################################################################################
" 
        read string

        echo "
Your string is: $string 
"
        enter_continue
        break 
        ;;

    "")
        string="#FreeRoss.org - Sign the petition. " #default string if no customised string selected
	    break
        ;;
    s|S) return 0 ;;
    *)
        invalid
        continue
        ;;
esac    
done

# break point from while
please_wait
# "status=progress" won't work becuase of the pipe, but leving it in for future reference.
if [[ $OS == "Linux" ]] ; then
    remove_fstab_entry
    yes "$string " | sudo dd iflag=fullblock of=/dev/$disk bs=1M count=500 >/dev/null 2>&1 && sync && return 0
    fi
if [[ $OS == "Mac" ]] ; then
    yes "$string " | sudo dd of=/dev/$disk bs=1000000 count=500 >/dev/null 2>&1 && sync && return 0
    fi

# if it ran successfully, code exits.    

echo " 
Wiping the drive failed for some reason. Aborting.
"
enter_continue
exit 1
}