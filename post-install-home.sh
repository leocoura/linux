
#==========
# Configurar o history com timestamp

echo 'export HISTTIMEFORMAT="%d/%m/%y %T "' >> /etc/profile
echo 'export HISTTIMEFORMAT="%d/%m/%y %T "' >> /root/.profile


#==========
# Configurar alguns alias de comandos

echo 'alias l="ls -laF"' >> /etc/profile
echo 'alias nano="nano -w"' >> /etc/profile
echo 'alias du="du -h --max-depth 1"' >> /etc/profile
echo 'alias l="ls -laF"' >> /root/.profile
echo 'alias nano="nano -w"' >> /root/.profile
echo 'alias du="du -h --max-depth 1"' >> /root/.profile


#==========
# Configurar o vi/vim para ignorar letras maiusculas/minusculas

echo 'set ignorecase' >> /etc/vim/vimrc


#==========
# Configurar o screen

echo 'shell -$SHELL' >> /etc/screenrc



#==========
# Executar o screen

###   screen


#==========
# Permitir login ROOT via SSH para faixa 172.27.2.0 e 172.27.5.0

echo 'Match address 172.27.2.0/24' >> /etc/ssh/sshd_config
echo '    PasswordAuthentication yes' >> /etc/ssh/sshd_config
echo '    PermitRootLogin yes' >> /etc/ssh/sshd_config
echo 'Match address 172.27.5.0/24' >> /etc/ssh/sshd_config
echo '    PasswordAuthentication yes' >> /etc/ssh/sshd_config
echo '    PermitRootLogin yes' >> /etc/ssh/sshd_config
echo 'Match address 192.168.0.0/24' >> /etc/ssh/sshd_config
echo '    PasswordAuthentication yes' >> /etc/ssh/sshd_config
echo '    PermitRootLogin yes' >> /etc/ssh/sshd_config



#==========
# NTP - hora do sistema

rm /etc/localtime 
ln -ns /usr/share/zoneinfo/Brazil/East /etc/localtime


#==========
# Configurar ntp no crontab
echo 'MAILTO=root' >> /etc/cron.d/ntpdate
#echo '0 * * * * /usr/sbin/ntpdate ntp.brz.fu.int.unesco.org > /dev/null 2>&1' >> /etc/cron.d/ntpdate



#==== CRONTAB
# Alterar o horário do crontab diário/semanal/mensal
# O horário normal é algo perto das 6 da manhã. Alterar para 0 hora e x minutos

#vi /etc/crontab



#==========
# Desabilitar o reboot via ctrl-alt-del
systemctl mask ctrl-alt-del.target
systemctl daemon-reload


#==========
#Configurar default shell
echo "dash dash/sh boolean false" | debconf-set-selections
sudo dpkg-reconfigure -f noninteractive dash



#==========
# Configurar proxy para o APT / APT-CACHER

#echo 'Acquire::http { Proxy "http://apt.unesco.org.br:3142"; };' >> /etc/apt/apt.conf.d/02proxy
apt update



#==========
# Remover o vim-tiny e instalar o vim completo
apt -y remove vim-tiny 
apt -y install ntpdate vim
update-alternatives --set editor /usr/bin/vim.basic


#===============
#Desabilitar unattended upgrades
	
apt -y remove unattended-upgrades


#==========
# Atualizar o sistema via apt e reiniciar a maquina

apt -y upgrade

reboot
