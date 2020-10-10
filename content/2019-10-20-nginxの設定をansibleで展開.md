---
title: "Nginxの設定をAnsibleで展開"
date: "2019-10-20T11:30:11.000Z"
categories: 
  - "log"
  - "tech-blog"
tags: 
  - "ansible"
  - "nginx"
---

どんすわサーバー内に入って  
Nginxの設定ファイルどこにあるのかなあと探して見つけました。

/etc/nginx$ cat nginx.conf

出てきたnginx.confをcopyして  
ローカルのdon.suwa3.me-ansibleに追加したらGitHubにpushです。  
https://github.com/suwa3/don.suwa3.me-ansible/blob/master/nginx.conf

ついでにyamlも追加

\- hosts: all 
  tasks: 
    - name:nginx.conf 
      become: yes 
      template: 
        src: nginx.conf 
        dest: /etc/nginx/nginx.conf 
        owner: root 
        group: root 
        mode: 0644

そういえばポートを22222に変更していたので  
ポート番号の変更を追記しました。

$ sudo vi ansible.cfg 
\[defaults\] 
hostfile = ./hosts 
remote\_port = 22222

playbookしてみます。

$ ansible-playbook -i hosts nginx.yaml 
\_\_\_\_\_\_\_\_\_\_\_\_ 
< PLAY \[all\] > 
------------ 
        \\   ^\_\_^ 
         \\  (oo)\\\_\_\_\_\_\_\_ 
            (\_\_)\\       )\\/\\ 
                ||----w | 
                ||     || 

無事okでました〜  
やったねえ
