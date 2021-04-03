---
title: "Kubernetes Middle Way"
date: "2021-01-24T10:00:00.000Z"
categories: 
  - "tech-blog"
tags: 
  - "Kubernetes"
---

# Kubernetes Middle Way

Kubernetes Middle Way の最終セッションの内容が良さげだったのでまとめました！

[https://www.youtube.com/watch?v=KmM16GHwies&feature=youtu.be](https://www.youtube.com/watch?v=KmM16GHwies&feature=youtu.be)

[スライド資料](https://speakerdeck.com/hhiroshell/kubernetes-network-fundamentals-69d5c596-4b7d-43c0-aac8-8b0e5a633fc2)

## 整理しながら理解する、Kubernetesのネットワークの仕組み by [@hhiroshell](https://twitter.com/hhiroshell)

### 1. イントロダクション

Kubernetes のネットワークはいろいろな用語が出てきて把握が難しい

このセッションのゴール

* Kubernetes のネットワークの全体像を理解する
* 様々な構成要素の役割と関係性を整理して把握
* ネットワーク周りのドキュメントの言っていることがわかる

### 2. Kubernetes のネットワークのアーキテクチャ

全体を4つに分けて考えてみる

1. インフラによって実態は異なる

ベアメタルなど。なんだろう[ベアメタル](https://baremetal.jp/blog/2017/05/15/272/)って・・🤔🐻くま？
Node Network
2. Node Network 上にソフトウェア的に構成される論理ネットワーク

要件がいろいろとあるらしい

クラスター内の全 Pod が、互いのIPアドレスで[NAT](https://www.infraexpert.com/study/ip10.html)なしで変換できるなど
Pod Network / Cluster Network
3. Pod を Cluster 内のネットワークに参加させる

kubelet が Pod を起動するときに CNI プラグインを実行することで上記を行っている
kubelet と CNI プラグイン
4. Pod に対する通信において、名前解決・ロードバランシング・サービスディスカバリなどの機能を提供する
Service Network

### 3. Cluster Network

公式ドキュメントでは"Cluster Networking"。自力構築する場合は Flannel, Calico などを使う

Flannel って？

[https://kubernetes.io/ja/docs/concepts/cluster-administration/networking/#flannel](https://kubernetes.io/ja/docs/concepts/cluster-administration/networking/#flannel)

’’ Flannel is a very simple overlay network that satisfies the Kubernetes requirements. Many people have reported success with Flannel and Kubernetes. (Flannelは、Kubernetesの要件を満たす非常にシンプルなオーバーレイネットワークです。多くの人がFlannelとKubernetesで成功したと報告しています。)

ほえー！

Linux Bridge と VXLAN によるカプセル化を組み合わせて、Node をまたぐ通信を抽象化

VXLAN によるカプセル化とは: Flannel のデーモンプロセスによって、宛先の Pod が起動している Node 宛てとなるようにヘッダを追加する→[スライドp20〜24の図](https://speakerdeck.com/hhiroshell/kubernetes-network-fundamentals-69d5c596-4b7d-43c0-aac8-8b0e5a633fc2?slide=20)が分かりやすかった！✨192.168.2.2を、192.168.254.12が包んでいる(カプセル化している)。

【参考】

* [https://docs.openstack.org/liberty/ja/networking-guide/scenario-classic-lb.html](https://docs.openstack.org/liberty/ja/networking-guide/scenario-classic-lb.html)
シナリオ: Linux Bridge を使った基本構成
* [https://kubernetes.io/ja/docs/concepts/cluster-administration/networking/#project-calico](https://kubernetes.io/ja/docs/concepts/cluster-administration/networking/#project-calico)

’’ Project Calico is an open source container networking provider and network policy engine. (Project Calicoは、オープンソースのコンテナネットワーキングプロバイダーおよびネットワークポリシーエンジンです。)
project-calico

### 4. kubelet と CNI プラグイン

* Pod を起動/停止する処理

CNI プラグインを実行する
kubelet
* Container Network Interface (CNI) 要件を満たす実装

Pod をネットワークに参加させるのに必要な処理を実行 (kubeletからそれを呼び出す)

flannel であれば flannel plugin

NIC に IPアドレスを割り当てる
CNI プラグイン

### 5. Service Network

Service リソースによって以下のことが起きる

* Service に対応するIPアドレスの払い出し
* Service の IPアドレスに対して、ホスト名の割り当て＆クラスター内に DNSレコードが登録される
* Service に対するアクセスが Pods に対してロード・バランスされる
* 配送先の追加、除外が自動的に行われる

内部では

kube-proxy が Service (API サーバーにある)を見る→ Service の記述内容に合わせて Node 上の iptables を更新する

※ Proxy mode には v1.1 までのデフォルトである userspace プロキシモード、v1.2+ のデフォルトである iptables プロキシモード、ipvs プロキシモードなどがある。

[Servce].[Namespace].svc.cluster.local.

.svc.cluster.local. 部分は省略可能だが、パフォーマンスの観点では完全修飾名を指定するのが良いとのこと。

**クラスター外からの通信の受け入れ**

Service

* Type: NodePort
* Type: LoadBalancer

Ingress

↑このあたりは検証で**構築したの出来てる？**って見るときに使ったぞい\\٩( 'ω' )و //

### 🌼 所感 🌼

用語と全体の動きをザックリと把握するのに良い資料だなぁと思いました。

Flannel や、内部の VXLAN によるカプセル化について図で納得できたのは収穫でした！
![image.png](image/image.png)
