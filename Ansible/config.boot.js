interfaces {
    ethernet eth0 {
        address "10.0.17.200/24"
        hw-id "00:50:56:9b:d5:22"
    }
    ethernet eth1 {
        address "10.0.5.2/24"
        hw-id "00:50:56:9b:c4:aa"
    }
    loopback lo {
    }
}
nat {
    source {
        rule 10 {
            outbound-interface {
                name "eth0"
            }
            source {
                address "10.0.5.0/24"
            }
            translation {
                address "masquerade"
            }
        }
    }
}
protocols {
    static {
        route 0.0.0.0/0 {
            next-hop 10.0.17.2 {
            }
        }
    }
}
service {
    dns {
        forwarding {
            allow-from "10.0.5.0/24"
            listen-address "10.0.5.2"
            system
        }
    }
    ntp {
        allow-client {
            address "0.0.0.0/0"
            address "::/0"
        }
        server time1.vyos.net {
        }
        server time2.vyos.net {
        }
        server time3.vyos.net {
        }
    }
    ssh {
        listen-address "0.0.0.0"
    }
}
system {
    config-management {
        commit-revisions "100"
    }
    conntrack {
        modules {
            ftp
            h323
            nfs
            pptp
            sip
            sqlnet
            tftp
        }
    }
    console {
        device ttyS0 {
            speed "115200"
        }
    }
    host-name "fw-blue1"
    login {
        user vyos {
            authentication {
                encrypted-password "$6$rounds=656000$g.jvrZMHuBnAczAR$vusEoR766bzbjWzYQQ8/qOamuURtXaLzh1r.YtgE1bf7d7x5P4gg7kCKBiCtaeNy2rOcmqjz5/qYWBT.J5LLB0"
                plaintext-password ""
            }
        }
    }
    name-server "10.0.17.4"
    syslog {
        global {
            facility all {
                level "info"
            }
            facility local7 {
                level "debug"
            }
        }
    }
}


// Warning: Do not remove the following line.
// vyos-config-version: "bgp@5:broadcast-relay@1:cluster@2:config-management@1:conntrack@5:conntrack-sync@2:container@1:dhcp-relay@2:dhcp-server@10:dhcpv6-server@5:dns-dynamic@4:dns-forwarding@4:firewall@14:flow-accounting@1:https@6:ids@1:interfaces@32:ipoe-server@3:ipsec@13:isis@3:l2tp@9:lldp@2:mdns@1:monitoring@1:nat@7:nat66@3:ntp@3:openconnect@2:openvpn@1:ospf@2:pim@1:policy@8:pppoe-server@9:pptp@5:qos@2:quagga@11:rip@1:rpki@2:salt@1:snmp@3:ssh@2:sstp@6:system@27:vrf@3:vrrp@4:vyos-accel-ppp@2:wanloadbalance@3:webproxy@2"
// Release version: 1.5-rolling-202403240305
