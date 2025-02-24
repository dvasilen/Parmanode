function remove_programs {

if ! grep -q parmanode $HOME/.parmanode/installed.conf ; then 
set_terminal ; echo "
########################################################################################

    Intsall Parmanode before trying to remove anyting... obviously!

########################################################################################
"
enter_continue
return 1 
fi

while true ; do
set_terminal

echo "
########################################################################################

             Remove Programs

"
if grep -q "parmanode-end" $HOME/.parmanode/installed.conf ; then
echo "                                           (parmanode)        Parmanode
" ; fi
if grep -q "bitcoin-end" $HOME/.parmanode/installed.conf ; then bitcoinmenu=1
echo "                                           (bitcoin)          Bitcoin Core
"
elif grep -q "bitcoin-start" $HOME/.parmanode/installed.conf ; then bitcoinmenu=1
echo "                                           (bitcoin)          Bitcoin (partial)
" ; fi
if grep -q "fulcrum-end" $HOME/.parmanode/installed.conf ; then fulcrummenu=1 
echo "                                           (fulcrum)          Fulcrum Server
"
elif grep -q "fulcrum-start" $HOME/.parmanode/installed.conf ; then fulcrummenu=1                                
echo "                                           (fulcrum)          Fulcrum (partial)
" ; fi
if grep -q "docker-end" $HOME/.parmanode/installed.conf ; then dockermenu=1 
echo "                                           (docker)           Docker 
"
elif grep -q "docker-start" $HOME/.parmanode/installed.conf ; then dockermenu=1                       
echo "                                           (docker)           Docker (partial) 
" ; fi
if grep -q "btcpay-end" $HOME/.parmanode/installed.conf ; then btcpaymenu=1              
echo "                                           (btcp)             BTCPay 
"
elif grep -q "btcpay-start" $HOME/.parmanode/installed.conf ; then btcpaymenu=1                               
echo "                                           (btcp)             BTCPay (partial) 
" ; fi
#############################
if [[ $OS != "Mac" ]] ; then
if which tor >/dev/null 2>&1 ; then tormenu=1
echo "                                           (tor)              Tor 
"
elif grep -q "tor-start" $HOME/.parmanode/installed.conf ; then tormenu=1
echo "                                           (tor)              Tor (partial)
" ; fi
fi
#############################
if grep -q "lnd-end" $HOME/.parmanode/installed.conf ; then lndmenu=1
echo "                                           (lnd)              LND 
"
elif grep -q "lnd-start" $HOME/.parmanode/installed.conf ; then lndmenu=1
echo "                                           (lnd)              LND (partial) 
" ; fi
if grep -q "mempool-end" $HOME/.parmanode/installed.conf ; then mempoolmenu=1
echo "                                           (mem)              Mempool Space 
"
elif grep -q "mempool-start" $HOME/.parmanode/installed.conf ; then mempoolmenu=1
echo "                                           (mem)              Mempool (partial) 
" ; fi
if grep -q "sparrow-end" $HOME/.parmanode/installed.conf ; then sparrowmenu=1
echo "                                           (s)                Sparrow Wallet 
"  
elif grep -q "sparrow-start" $HOME/.parmanode/installed.conf ; then sparrowmenu=1
echo "                                           (s)                Sparrow (partial) 
" ; fi
if grep -q "rtl-end" $HOME/.parmanode/installed.conf ; then rtlmenu=1
echo "                                           (r)                RTL Wallet 
"  
elif grep -q "rtl-start" $HOME/.parmanode/installed.conf ; then rtlmenu=1
echo "                                           (r)                RTL (partial) 
" ; fi
if grep -q "electrum-end" $HOME/.parmanode/installed.conf ; then electrummenu=1
echo "                                           (e)                Electrum Wallet 
"  
elif grep -q "electrum-start" $HOME/.parmanode/installed.conf ; then electrummenu=1
echo "                                           (e)                Electrum (partial) 
" ; fi
if grep -q "tor-server-end" $HOME/.parmanode/installed.conf ; then torservermenu=1
echo "                                           (ts)               Tor Server 
"
elif grep -q "tor-server-start" $HOME/.parmanode/installed.conf ; then torservermenu=1
echo "                                           (ts)               Tor Server (partial) 
" ; fi
if grep -q "btcpTOR-end" $HOME/.parmanode/installed.conf ; then btcpTORmenu=1
echo "                                           (btcpt)            Tor Server 
"
elif grep -q "btcpTOR-start" $HOME/.parmanode/installed.conf ; then btcpTORmenu=1
echo "                                           (btcpt)            Tor Server (partial) 
" ; fi
if grep -q "specter-end" $HOME/.parmanode/installed.conf ; then spectermenu=1
echo "                                           (specter)          Specter Wallet 
"
elif grep -q "specter-start" $HOME/.parmanode/installed.conf ; then spectermenu=1
echo "                                           (specter)          Specter Wallet 
" ; fi
echo "
########################################################################################
"
choose "xpq"
read choice

case $choice in

parmanode|PARMANODE|Parmanode)
uninstall_parmanode
exit 0
;;

bitcoin|Bitcoin|BITCOIN)
if [[ $bitcoinmenu == 1 ]] ; then
uninstall_bitcoin
return 0
fi
;;

fulcrum|Fulcrum|FULCRUM)
if [[ $fulcrummenu == 1 ]] ; then
uninstall_fulcrum
return 0
fi
;;

docker|Docker|DOCKER)
if [[ $dockermenu == 1 ]] ; then
if [[ $OS == "Mac" ]] ; then uninstall_docker_mac ; continue ; fi
uninstall_docker_linux 
return 0
fi
;;

btcp|BTCP|Btcp)
if [[ $btcpaymenu == 1 ]] ; then
uninstall_btcpay
return 0
fi
;;

TOR|Tor|tor)
if [[ $tormenu == 1 ]] ; then
no_mac || return 1
uninstall_tor
return 0
fi
;;

lnd|LND|Lnd)
if [[ $lndmenu == 1 ]] ; then
if [[ $OS == "Linux" ]] ; then uninstall_lnd ; return 0 ; fi
fi
;;

mem|MEM|Mem)
if [[ $mempoolmenu == 1 ]] ; then
uninstall_mempool
return 0
fi
;;

s|S|SPARROW|Sparrow|sparrow)
if [[ $sparrowmenu == 1 ]] ; then
    uninstall_sparrow
	return 0 
	fi
	;;
R|r|RTL|rtl|Rtl)
if [[ $rtlmenu == 1 ]] ; then
	uninstall_rtl
	return 0
	fi
	;;

e|E|Electrum|electrum|ELECTRUM)
if [[ $electrummenu == 1 ]] ; then
    uninstall_electrum
	return 0
	fi
	;;
ts|TS|Ts)
if [[ $torservermenu == 1 ]] ; then
	no_mac || return 1
	uninstall_tor_server
	return 0
	fi
	;;
btcpt|BTCPT)
if [[ $btcpTORmenu == 1 ]] ; then
	no_mac || return 1
	uninstall_btcpay_tor
	return 0
	fi
    ;;
specter|SPECTER|Specter)
if [[ $spectermenu == 1 ]] ; then
    uninstall_specter
	return 0
	fi
	;;

p|P)
	return 0
	;;

q|Q|QUIT|quit|Quit)
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
