"■原因
kindで構築したノード（kubernetesを構築しているVMイメージのコンテナ）上に拠点ごとの証明書が適用されていないため。
helmで実際にingress-nginxのpodを作成しようとするがimageのpullに失敗している。

■対応
kindで作成した各ノードに拠点用の証明書をインストールする

■手順
---中途半端なingress-nginxを削除する
$ helm -n ingress-nginx list
→ ingress-nginxを確認
$ helm -n ingress-nginx uninstall ingress-nginx
→ 一度削除
$ kubectl delete ns ingress-nginx
→完全にingress-nginxを削除する

---証明書を追加する
$ kind get nodes
→出力されたリストを確認し、全ノードに対して実行

以下、kind-worker2に対して東京第2オフィスの証明書を適用した例

docker cp ../../Osaka_2022_Fortinet_CA_SSL.cer kind-worker2:/usr/share/ca-certificates/
docker exec kind-worker2 sh -c "echo Osaka_2022_Fortinet_CA_SSL.cer >> /etc/ca-certificates.conf"
docker exec kind-worker2 sh -c "update-ca-certificates"
docker exec kind-worker2 sh -c "ls -l /etc/ssl/certs/ | grep Osaka_2022_Fortinet_CA_SSL.cer"


docker cp ../../Osaka_2022_Fortinet_CA_SSL.cer kind-control-plane:/usr/share/ca-certificates/
docker exec kind-control-plane sh -c "echo Osaka_2022_Fortinet_CA_SSL.cer >> /etc/ca-certificates.conf"
docker exec kind-control-plane sh -c "update-ca-certificates"
docker exec kind-control-plane sh -c "ls -l /etc/ssl/certs/ | grep Osaka_2022_Fortinet_CA_SSL.cer"


WSL2の場合は、

sudo service docker restart


1. windows側のhostsファイル修正
演習を通して利用するIPアドレスとドメインの紐付けを設定してください。
IPアドレスは127.0.0.1です。
```
127.0.0.1    app.example.com
...
```

2. 3つのノードに対して証明書を適用する
```
$ sudo  kind get nodes
kind-worker
kind-worker2
kind-control-plane
```

3. wls側のdocker再起動
`sudo service docker restart`



--- 再度ingress-nginxをインストールする
ここからは同じ様にhelmfileのコマンド実行"



docker exec kind-worker2 sh -c "echo xxx_CA_SSL.cer >> /etc/ca-certificates.conf"




sudo sh -c "echo 'nameserver 8.8.8.8' > /etc/resolv.conf"



docker exec kind-worker2 sh -c "tail /etc/ca-certificates.conf"

------------------------

cd cndt-handson/cndt2023-handson-fork/chapter01_cluster-create/


# show all releases in all namespace
helm ls -aA



kubercrl -n algo-d get pw



#ArgoCD上でrolloutの操作結果が確認できるようにします。
kubectl apply -n argo-cd -f https://raw.githubusercontent.com/argoproj-labs/rollout-extension/v0.2.1/manifests/install.yaml

#Argo Rolloutsのインストール
helmfile sync -f ./helm/helmfile.yaml
kubectl get service,deployment  -n argo-rollouts

#Corednsへhostの追加
kubectl edit cm coredns -n kube-system

kubectl -n prothnus get svc

kubectl -n kube-system rollout restart deployment

 kubectl -n kube-system get all
 
 