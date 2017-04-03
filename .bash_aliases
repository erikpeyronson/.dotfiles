#alias sshserver='ssh 192.168.0.200'
alias sshserverx='ssh -X 192.168.0.200'
alias sshida='ssh eripe320@remote-und.ida.liu.se'
alias sshidax='ssh -X eripe320@remote-und.ida.liu.se'

alias sshmaster='ssh -X -p 2222 root@localhost'
alias sshserver='ssh -X -p 2223 root@localhost' 
alias sshclient='ssh -X -p 2224 root@localhost'
  

alias unrarall='unrar -r e *.rar'
alias vpn='sudo openvpn --config ~/.vpn/AzireVPN-SE.ovpn'
alias scan-image='sudo scanimage --mode Gray --resolution 300 > /storage/dokument/scan/raw/scan.tiff'

#gcc aliases
alias g++14='g++ -std=c++14 -Wall -pedantic -Wall -Wextra'
alias g++11='g++ -std=c++11 -Wall -pedantic -Wall -Wextra'


alias g++14debug='g++ -std=c++14 -Wall -g'

#prompt aliases
alias shortprompt='PS1="\[\033[01;32m\]\u\[\033[00m\]\$ "'
alias longprompt='PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\ $ "'
alias gitprompt='PS1="$(__git_ps1)$PS1"'  

alias sd='sudo shutdown now'
alias synctorrents='scp ~/Downloads/torrents 192.168.0.200:/storage/rtorrent/torrents'

alias swapcaps='setxkbmap -option ctrl:swapcaps'
