# zabbix-bird-linux

Put bird_mon.sh to /etc/zabbix/scripts/ and userparameter_bird_mon.conf to /etc/zabbix/zabbix_agent2.d/


###########################

Run in console:

echo "zabbix ALL=NOPASSWD: /usr/sbin/birdc" >> /etc/sudoers.d/zabbix;

usermod -a -G bird zabbix;

chmod +x /etc/zabbix/scripts/bird_mon.sh;

systemctl restart zabbix-agent2

###########################


Import zbx_export_templates.json to Zabbix
