#!/bin/bash
clear
echo "MENU DROPBEAR"
echo ""
echo "[1] ATIVAR"
echo "[2] DESATIVAR"
read -p opcao
case $opcao in
1)
#ativando
cp /etc/default/dropbear /etc/default/dropbear.bkp
echo "CONFIGUARNDO DROPBEAR..."
sleep 3
echo "#Dropbear" > /etc/default/dropbear
echo "NO_START=0" >> /etc/default/dropbear
echo "DROPBEAR_PORT=443" >> /etc/default/dropbear
echo 'DROPBEAR_EXTRA_ARGS="-p 80"' >> /etc/default/dropbear
# DESATIVANDO A PORTA 443 NO SSH
grep -v "^Port 443" /etc/ssh/sshd_config > /tmp/ssh && mv /tmp/ssh /etc/ssh/sshd_config
echo "#Port 443" >> /etc/ssh/sshd_config
# REINICIANDO SERVIÇOS
service squid3 stop && service ssh restart && service dropbear start && service dropbear restart
echo "REINICIANDO SERVIÇOS..."
sleep 3
echo "DROPBEAR CONFIGURADO!"
sleep 5
;;
2)
#desativando
clear
echo "AGUARDE UM MOMENTO..."
sleep 3
clear
echo "DESATIVANDO DROPBEAR..."
sleep 3
clear
mv /etc/default/dropbear.bkp /etc/default/dropbear
# ATIVANDO A PORTA 443 NO SSH
grep -v "^#Port 443" /etc/ssh/sshd_config > /tmp/ssh && mv /tmp/ssh /etc/ssh/sshd_config
echo "Port 443" >> /etc/ssh/sshd_config
# REINICIANDO SERVIÇOS
service squid3 stop && service ssh restart && service dropbear stop
echo "REINICIANDO SERVIÇOS..."
sleep 3
clear
echo "DROPBEAR DESATIVADO!"
sleep 5
;;
*)
echo "OPÇÃO INVÁLIDA!"
sleep 3
esac