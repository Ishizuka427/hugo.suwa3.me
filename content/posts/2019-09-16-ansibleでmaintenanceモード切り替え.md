---
title: "AnsibleでMaintenanceモード切り替え"
date: "2019-09-16T05:00:22.000Z"
categories: 
  - "%e6%9c%aa%e5%88%86%e9%a1%9e"
tags: 
  - "ansible"
---

ふだんdon.suwa3.meが不安定になって

Maintenanceモードに切り替えるとき手動で行っていたので

Ansibleの構成管理に組み込みました。

完成品こちらです

![](http://wp.suwa3.me/wp-content/uploads/2019/09/e382b9e382afe383aae383bce383b3e382b7e383a7e38383e38388-2019-09-16-14.01.32.png?w=685)

### ファイルモジュールでシンボリックリンクの切り替えを設定

$ sudo ln -sf /etc/nginx/sites-available/don.suwa3.me-mainte /etc/nginx/sites-enabled/don.suwa3.me

↑普段切り替えに使っているコマンド

（ 参照ドキュメントページ ）

[file – Manage files and file properties — Ansible Documentation](https://docs.ansible.com/ansible/latest/modules/file_module.html)

    - name: changed maintenance page 
      become: yes 
      file: 
          src: /etc/nginx/sites-available/don.suwa3.me-mainte 
          dest: /etc/nginx/sites-enabled/don.suwa3.me 
          state: link 

become: yesはsudo実行

Src:は、どこから

dest:は、どこへ

state:は、何を？ってかんじ

* * *

### serviceモジュールでNginxのリロードを設定

 $ sudo service nginx reload 

↑普段リロードに使っているコマンド

（ 参照ドキュメントページ ）

[service – Manage services — Ansible Documentation](https://docs.ansible.com/ansible/latest/modules/service_module.html)

    - name: Restart service httpd, in all cases 
      become: yes 
      service: 
          name: nginx.service 
          state: reloaded 

serviceモジュールでうまくいかなかったので

Ansible service module **vs**

でサジェクトされた systemdモジュールを使ってみることにしました。

vs！！！

（ 参照ドキュメントページ ）

[systemd – Manage services — Ansible Documentation](https://docs.ansible.com/ansible/latest/modules/systemd_module.html)

    - name: Restart service httpd, in all cases 
      become: yes 
      systemd: 
          name: nginx.service 
          state: reloaded 

無事成功です！

この要領でNormal.yamlも作成し、動作確認して成功しました。

Ansibleは公式のドキュメントに例がたくさん載っているので

何のモジュールを使うべきか決まっている場合には

公式を見るのが早いなとおもいました。

あとはvsでサジェクトされたものも試してみると

案外うまく行く場合もあるのかもしれないとおもいました🙋‍♀️

![](http://wp.suwa3.me/wp-content/uploads/2019/09/e382b9e382afe383aae383bce383b3e382b7e383a7e38383e38388-2019-09-16-14.47.36.png?w=972)

GitHubのREADME.mdの画像もリニューアルしました！

https://github.com/suwa3/don.suwa3.me-ansible
