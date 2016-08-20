function hmmq() {
cat <<EOF
- cdq:   Go to the directory.
- svn_exportq 
Environemnt options:
- SANITIZE_HOST: Set to 'true' to use ASAN for all host modules. Note that
                 ASAN_OPTIONS=detect_leaks=0 will be set by default until the
                 build is leak-check clean.

Look at the source to view more functions. The complete list is:
EOF
    T=$(gettop)
    local A
    A=""
    for i in `cat $T/workq/myshell.sh | sed -n "/^[ \t]*function /s/function \([a-z_]*\).*/\1/p" | sort | uniq`; do
      A="$A $i"
    done
    echo $A
}


function gettop
{
    local TOPFILE=build/core/envsetup.mk
    if [ -n "$TOP" -a -f "$TOP/$TOPFILE" ] ; then
        # The following circumlocution ensures we remove symlinks from TOP.
        (cd $TOP; PWD= /bin/pwd)
    else
        if [ -f $TOPFILE ] ; then
            # The following circumlocution (repeated below as well) ensures
            # that we record the true directory name and not one that is
            # faked up with symlink names.
            PWD= /bin/pwd
        else
            local HERE=$PWD
            T=
            while [ \( ! \( -f $TOPFILE \) \) -a \( $PWD != "/" \) ]; do
                \cd ..
                T=`PWD= /bin/pwd -P`
            done
            \cd $HERE
            if [ -f "$T/$TOPFILE" ]; then
                echo $T
            fi
        fi
    fi
}

function cdq () {
#    cdlist= ""
    if [[ -z "$1" ]]; then
        echo "Usage: cdq <regex>"
        echo "regex: root k_lcm l_lcm k_imgs h_imgs touch arm_dts arm_conf out" 
        return
    fi
    T=$(gettop)

    case $1 in
        root) cdqdir=./
            ;;
        k_lcm) cdqdir=kernel-3.18/drivers/misc/mediatek/lcm
            ;;
        l_lcm) cdqdir=vendor/mediatek/proprietary/bootable/bootloader/lk/dev/lcm 
            ;;
        k_imgs) cdqdir=kernel-3.18/drivers/misc/mediatek/imgsensor
            ;;
        h_imgs) cdqdir=vendor/mediatek/proprietary/custom/mt6735/hal/D2
            ;;
        touch) cdqdir=kernel-3.18/drivers/input/touchscreen/mediatek
            ;;
        arm_dts) cdqdir=kernel-3.18/arch/arm/boot/dts
            ;;
        arm_conf) cdqdir=kernel-3.18/arch/arm/configs;
            ;;
        out) cdqdir=out/target/product
            ;;
        *)
            echo "Can't find the dir $1"
            cdqdir= /bin/pwd
            ;;
    esac
    \cd $T/$cdqdir
}


function svn_exportq () {

    if [[ -z "$1" ]]; then
        echo "Usage: svn_exportq <url> <dir>"
        echo "url: f5c_37m wf5_80" 
        return
    fi
    T=$(gettop)

    case $1 in
        f5c_37m) svnurl=/branches/ALPS-MP-M0.MP1-V2.84_DROI6737M_65_M0/pcb_oversea
            ;;
        wf5_80) svnurl=svn://192.168.0.230/mt6580/branches/ALPS-MP-M0.MP1-V2.34_DROI6580_WE_M/odm
            ;;
        *)
            echo "Can't find the url $1"
            return
            ;;
    esac
    echo "$T/$svnurl/$2"
}

function rm_cp_mk () {

    if [[ -z "$1" ]]; then
        echo "Usage: rm_cp_mk y"
        echo "rm cp of mk and svn restor" 
        return
    fi
    T=$(gettop)

    case $1 in
        y) echo "------ $1"
            ;;
        *)
            echo "Can't find the url $1"
            return
            ;;
    esac
}

