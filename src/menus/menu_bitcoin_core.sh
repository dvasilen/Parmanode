function menu_bitcoin_core {
while true
do
set_terminal_custom "45"
echo "
########################################################################################
                                 Bitcoin Core Menu                               
########################################################################################

"
if ps -x | grep bitcoind | grep "bitcoin.conf" >/dev/null 2>&1 ; then echo "
                   BITCOIN IS RUNNING -- SEE LOG MENU FOR PROGRESS "
else
echo "
                   BITCOIN IS NOT RUNNING -- CHOOSE \"start\" TO RUN"
fi
echo "


      (start)    Start Bitcoind............................................(Do it)

      (stop)     Stop Bitcoind..................(One does not simply stop Bitcoin)

      (restart)  Restart Bitcoind

      (c)        How to connect your wallet...........(Otherwise no point to this)

      (n)        Access Bitcoin node information ....................(bitcoin-cli)
	    
      (log)      Inspect Bitcoin debug.log file .....(Check if Bitcoin is running)

      (bc)       Inspect and edit bitcoin.conf file 

      (dd)       Backup/Restore data directory.................(Instructions only)

      (up)       Set, remove, or change RPC user/pass

      (ai)       Add rpcallowip values to bitcoin.conf........... (Advanced stuff)
      
      (tor)      Tor menu options for Bitcoin


########################################################################################
"
choose "xpq" ; read choice ; set_terminal

case $choice in

start|START|Start)
run_bitcoind
;;

stop|STOP|Stop)
stop_bitcoind
;;

restart|RESTART|Restart)
if [[ $OS == "Linux" ]] ; then sudo systemctl restart bitcoind.service ; fi
if [[ $OS == "Mac" ]] ; then
stop_bitcoind "no_interruption"
run_bitcoind "no_interruption"
fi
;;

c|C)
connect_wallet_info
continue
;;

n|N)
menu_bitcoin-cli
continue
;;

log|LOG|Log)
echo "
########################################################################################
    
    This will show the bitcoin debug.log file in real time as it populates.
    
    You can hit <control>-c to make it stop.

########################################################################################
"
enter_continue
set_terminal_wider
tail -f $HOME/.bitcoin/debug.log &
tail_PID=$!
trap 'kill $tail_PID' SIGINT #condition added to memory
wait $tail_PID # code waits here for user to control-c
trap - SIGINT # reset the trap so control-c works elsewhere.
set_terminal
continue ;;


bc|BC)
echo "
########################################################################################
    
        This will run Nano text editor to edit bitcoin.conf. See the controls
        at the bottom to save and exit. Be careful messing around with this file.

	Any changes will only be applied once you restart Bitcoin.

########################################################################################
"
enter_continue
nano $HOME/.bitcoin/bitcoin.conf
continue
;;


dd|DD)
echo "
########################################################################################
    
                          BACKUP BITCOIN DATA DIRECTORY    

    If you have a spare drive, it is a good idea to make a copy of the bitcoin data 
    directory from time to time. This could save you waiting a long time if you were 
    ever to experience data corruption and needed to resync the blockchain.

    It is VITAL that you stop bitcoind before copying the data, otherwise it will not 
    work correctly when it comes time to use the backed up data, and it's likely the 
    directory will become corrupted. You have been warned.

    You can copy the entire bitcoin_data directory.

    You could also just copy the chainstate directory, which is a lot smaller, and 
    this could be all that you need should there be a chainstate error one day. This 
    directory is smaller and it's more feasible to back it up frequently. I would 
    suggest doing it every 100,000 blocks or so, in addition to having a full copy 
    backed up if you have drive space somewhere.

    To copy the data, use your usual computer skills to copy files. The directory is 
    located either on the internal drive:

                        $HOME/.bitcoin

    or external drive:

                LINUX :   /media/$(whoami)/parmanode/.bitcoin 
                MAC   :   /Volumes/parmanode/.bitcoin

    Note that if you have an external drive for Parmanode, the internal directory 
    $HOME/.bitcoin is actually a symlink (shortcut) to the external 
    directory.

########################################################################################
"
enter_continue
continue
;;

up)
set_rpc_authentication
continue
;;

ai|AI|aI|Ai)
rpcallowip_add
continue
;;

tor|TOR|Tor)
menu_tor_bitcoin
continue
;;


p|P)
return 1
;;

q|Q|Quit|QUIT)
exit 0
;;

*)
invalid
continue
;;

esac

done
return 0
}


