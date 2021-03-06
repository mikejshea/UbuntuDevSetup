#! /bin/bash


readonly GOGLAND_INSTALLER=https://download-cf.jetbrains.com/go/gogland-163.12024.32.tar.gz
readonly ATOM_INSTALLER=https://atom.io/download/deb
readonly INTELLIJ_INSTALLER=https://download-cf.jetbrains.com/idea/ideaIU-2016.3.5.tar.gz
readonly WEBSTORM_INSTALLER=https://download-cf.jetbrains.com/webstorm/WebStorm-2016.3.4.tar.gz
readonly PYCHARM_INSTALLER=https://download-cf.jetbrains.com/python/pycharm-professional-2016.3.2.tar.gz
readonly ORACLE_JAVA_8_INSTALLER=http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jre-8u60-linux-x64.deb
readonly ORACLE_JAVA_8_JDK_INSTALLER=http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.deb
readonly SUBLIME_INSTALLER=https://download.sublimetext.com/sublime_text_3_build_3126_x64.tar.bz2
readonly CHROME_INSTALLER=https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.deb

if [ "root" != $USER ];
then
    echo Must run setup at \'root\', please use \'sudo bash\'.
    exit
fi

if [ ! -z "$(which dialog)" ];
then
    echo "Dialog installed"
else
    apt-get -y install dialog
fi

# Package: Atom
function CheckAtomVersion()
{
    if [ ! -z "$(which atom)" ];
    then
        echo "$(atom --version)"
    else
        echo "Not Installed"
    fi
}
function InstallAtom {
    wget $ATOM_INSTALLER
    mv deb atom-amd64.deb
    dpkg -i atom-amd64.deb
    apt-get -f install -y
    rm atom-amd64.deb
}

# Package: Git
function CheckGitVersion()
{
    if [ ! -z "$(which git)" ];
    then
        echo "$(git --version)"
    else
        echo "Not Installed"
    fi
}

# Package: VMWare Tools
function CheckVMWareToolsVersion()
{
    if [ ! -z "$(which vmware-toolbox-cmd)" ];
    then
        echo "$(vmware-toolbox-cmd -v)"
    else
        echo "Not Installed"
    fi
}

function InstallVMWareTools {
    echo Installing VMWare Tools
    echo    Extracting VMware Tools
    tar -xvzf /media/mshea/VMware\ Tools/VMwareTools-*.tar.gz -C /home/mshea/Downloads/

    echo Installing VMWare Tools
    /home/mshea/Downloads/vmware-tools-distrib/vmware-install.pl

    echo clean up VMWare Folder
    rm -rf /home/mshea/Downloads/vmware-tools-distrib
}

# Package: Terminator
function CheckTerminatorVersion()
{
    if [ ! -z "$(which terminator)" ];
    then
        echo "$(terminator -v 2> /dev/null)"
    else
        echo "Not Installed"
    fi
}

# Package: Docker
function CheckDockerVersion()
{
    if [ ! -z "$(which docker)" ];
    then
        echo "$(docker --version)"
    else
        echo "Not Installed"
    fi
}

function InstallDocker {
    # wget -qO- https://get.docker.com/ | sh
    # result=$(tempfile) ; chmod go-rw $result
    # whiptail --inputbox "What is your username?" 10 30 2>$result
    # usermod -aG docker $(cat $result)
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    apt-get update
    apt-get install -y docker-ce
}

function CheckChromeVersion()
{
    if [ ! -z "$(which google-chrome)" ];
    then
        echo "$(google-chrome --version)"
    else
        echo "Not Installed"
    fi
}



function CheckNodeJSVersion()
{
    if [ ! -z "$(which nodejs)" ];
    then
        echo "$(nodejs --version)"
    else
        echo "Not Installed"
    fi
}

function CheckSublimeVersion()
{
    if [ ! -z "$(which /opt/sublime_text/sublime_text)" ];
    then
        echo "$(/opt/sublime_text/sublime_text --version)"
    else
        echo "Not Installed"
    fi
}

function CheckEclipseVersion()
{
    if [ ! -z "$(which eclipse)" ];
    then
        echo "Installed"
    else
        echo "Not Installed"
    fi
}

function CheckWebstormVersion()
{
    if [ ! -z "$(which webstorm)" ];
    then
        echo "Installed"
    else
        echo "Not Installed"
    fi
}
function CheckOpenVPNVersion()
{
    if [ ! -z "$(which webstorm)" ];
    then
        echo "Installed"
    else
        echo "Not Installed"
    fi
}

function InstallUpdates {
    echo Start Updates
    apt-get update
    apt-get upgrade -y
    echo Finished Updates
}

function InstallChrome {
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    dpkg -i google-chrome-stable_current_amd64.deb
    apt-get -f install -y
    rm google-chrome-stable_current_amd64.deb
}

function InstallEclipse {
    ECLIPSE="eclipse-java-luna-SR2-linux-gtk-x86_64.tar.gz"
    ECLIPSEDESKTOP=/usr/share/applications/eclipse.desktop
    wget http://mirror.cc.vt.edu/pub/eclipse/technology/epp/downloads/release/luna/SR2/$ECLIPSE
    tar -xvzf $ECLIPSE -C /opt/
    ln -s /opt/eclipse/eclipse /usr/bin/eclipse
    rm $ECLIPSE

    echo "[Desktop Entry]" > $ECLIPSEDESKTOP
    echo "Name=Eclipse 4" >> $ECLIPSEDESKTOP
    echo "Type=Application" >> $ECLIPSEDESKTOP
    echo "Exec=/opt/eclipse/eclipse" >> $ECLIPSEDESKTOP
    echo "Terminal=false" >> $ECLIPSEDESKTOP
    echo "Icon=/opt/eclipse/icon.xpm" >> $ECLIPSEDESKTOP
    echo "Comment=Integrated Development Environment" >> $ECLIPSEDESKTOP
    echo "NoDisplay=false" >> $ECLIPSEDESKTOP
    echo "Categories=Development;IDE;" >> $ECLIPSEDESKTOP
    echo "Name[en]=Eclipse" >> $ECLIPSEDESKTOP

}

function InstallOpenVPN()
{
    apt-get install -y openvpn
    apt-get install -y network-manager-openvpn
    restart network-manager
}
function InstallSublime {
    wget http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3083_amd64.deb
    dpkg -i sublime-text_build-3083_amd64.deb
    apt-get -f install -y
    rm sublime-text_build-3083_amd64.deb
}



function InstallOracleJava8 {
    echo debconf shared/accepted-oracle-license-v1-1 select true | \
        debconf-set-selections
    echo debconf shared/accepted-oracle-license-v1-1 seen true | \
        debconf-set-selections
    add-apt-repository -y ppa:webupd8team/java
    apt-get update
    apt-get install -y oracle-java8-installer
}


function InstallWebStorm {
    wget http://download-cf.jetbrains.com/webstorm/WebStorm-10.0.4.tar.gz
    tar -xvzf WebStorm-10.0.4.tar.gz -C /opt/
    mv /opt/WebStorm* /opt/webstorm
    ln -s /opt/webstorm/bin/webstorm.sh /usr/bin/webstorm
    rm WebStorm-10.0.4.tar.gz
}

function InstallIntelliJ {
    wget https://d1opms6zj7jotq.cloudfront.net/idea/ideaIU-14.1.4.tar.gz
    tar -xvzf ideaIU-14.1.4.tar.gz -C /opt/
    mv /opt/idea-IU-141.1532.4 /opt/ideaIU
    ln -s /opt/ideaIU/bin/idea.sh /usr/bin/idea
    rm ideaIU-14.1.4.tar.gz
}

DIALOG=${DIALOG=dialog}
tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$
trap "rm -f $tempfile" 0 1 2 5 15

$DIALOG --backtitle "Check what you would like installed" \
	--title "Developer Setup" --clear \
        --checklist "Hi, you can select your favorite singer here  " 24 61 16 \
         "General_Updates" "" off \
         "VMWare_Tools" "$(CheckVMWareToolsVersion)" off \
         "Terminator" "$(CheckTerminatorVersion)" off \
         "Chrome" "$(CheckChromeVersion)" off \
         "Sublime" "$(CheckSublimeVersion)" off \
         "Atom" "$(CheckAtomVersion)" off \
         "Git" "$(CheckGitVersion)" off \
         "Maven" "" off \
         "Oracle_Java_8" "" off \
         "Eclipse" "$(CheckEclipseVersion)" off \
         "NodeJS" "$(CheckNodeJSVersion)" off \
         "WebStorm" "$(CheckWebstormVersion)" off \
         "Docker" "$(CheckDockerVersion)" off \
         "OpenVPN" "$(CheckOpenVPNVersion)" off \
         "Intellij" "" off \
         2> $tempfile

retval=$?

clear
choices=`cat $tempfile`
case $retval in
  1)
    echo "Cancel pressed."
    exit;;
  255)
    echo "ESC pressed."
    exit;;
esac

#choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
#clear
#echo $choises
##choice=`cat $tempfile`
for choice in $choices
do
    case $choice in
        "General_Updates")
            echo "X-General Updates"
            InstallUpdates
            ;;
        "VMWare_Tools")
            echo "X-VMWare Tools"
            InstallVMWareTools
            ;;
        "Terminator")
            echo "Install Terminator"
            apt-get install -y terminator
            ;;
        "Chrome")
            echo "X-Chrome"
            InstallChrome
            ;;
        "Sublime")
            echo "X-Sublime"
            InstallSublime
            ;;
        "Atom")
            echo "X-Atom"
            InstallAtom
            ;;
        "Git")
            echo "Install Git"
            apt-get install -y git
            ;;
        "Maven")
            echo "Install Maven"
            apt-get intall -y maven
            ;;
        "Oracle_Java_8")
            echo "X-Oracle_Java_8"
            InstallOracleJava8
            ;;
        "Eclipse")
            echo "X-Eclipse"
            InstallEclipse
            ;;
        "NodeJS")
            echo "Install NodeJS"
            apt-get install -y nodejs
            apt-get install -y npm
            ;;
        "WebStorm")
            echo "X-WebStorm"
            InstallWebStorm
            ;;
        "Docker")
            echo "X-Docker"
            InstallDocker
            ;;
        "OpenVPN")
            echo "X-OpenVPN"
            InstallOpenVPN
            ;;
        "Intellij")
            echo "X-Intellij"
            InstallIntelliJ
            ;;
    esac
done

echo Finished!
#case $retval in
#  0)
#    echo "'$choice' is your favorite singer";;
#  1)
#    echo "Cancel pressed.";;
#  255)
#    echo "ESC pressed.";;
#esac
