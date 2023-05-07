#restarts LND
function set_lnd_password {

while true ; do
set_terminal ; echo "
########################################################################################

                                  LND password
 
    Please type in a password for LND. Do not use the characters: # \" or ' otherwise
    bad things will happen to you.
    
    OR, (p) and <enter> to go back
    OR, (q) and <enter> to quit

########################################################################################
"
read lndpassword 
    if [[ $lndpassword == "p" ]] ; then return 1 ; fi
    if [[ $lndpassword == "q" ]] ; then exit 0 ; fi
set_terminal
echo "Please repeat the password:
"
read lndpassword2

#delete file, create file, later populate file.
rm $SHOME/.lnd/password.txt >/dev/null 2>&1
touch $HOME/.lnd/password.txt && chmod 600 $HOME/.lnd/password.txt


if [[ $lndpassword != $lndpassword2 ]] ; then
    echo "Passwords do not match. Try again."
    enter_continue ; continue
else
    echo "Password set"
    echo "$lndpassword" > $HOME/.lnd/password.txt 
    enter_continue
    break
fi

done
}