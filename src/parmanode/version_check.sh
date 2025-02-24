function update_version_info {
#called by run_parmanode

#must be in this order
export_latest_version
export_local_version
check_backwards_compatibility
if [[ $version_incompatibility != 1 ]] ; then
    check_for_updates

        if [[ $old_version == 1 ]] ; then
            old_version_detected
        fi
fi
}

function check_for_updates {
if [[ $latest_version != $version ]] ; then
    export old_version=1
    return 0
    fi
}

function old_version_detected {
while true ; do
set_terminal ; echo "
########################################################################################

    The version of Parmanode you are running is not up to date. Would you like to
    update Parmanode now? 

                y)         Yes
                
                n)         No 
    
    The apps you have already installed will not be changed.

########################################################################################
"
choose "xq" ; read choice
case $choice in
N|no|NO|No|n) return 0 ;;
y|Y|YES|Yes|yes) update_parmanode ;;
*) invalid ;;
esac
done
}

function check_backwards_compatibility {
if [[ $latest_vMajor < $vMajor ]] ; then
export version_incompatibility=1
fi
}

function export_latest_version {
curl -s https://raw.githubusercontent.com/ArmanTheParman/Parmanode/master/version.conf > /tmp/latest_version.txt
source /tmp/latest_version.txt && rm /tmp/latest_version.txt >/dev/null
export latest_version="$version" >/dev/null
export latext_vMajor="$vMajor" >/dev/null
export latest_vMinor="$vMinor" >/dev/null
export latest_vPatch="$vPatch" >/dev/null
}

function export_local_version {
source ./version.conf
export version ; export vMajor ; export vMinor ; export vPatch
}
