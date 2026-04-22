# g1 - Context tonen
kubectl config current-context

---
# g2 - Nodes tonen
kubectl get nodes

---
# g3 - Pods bekijken
kubectl get pods -A

---
# g4 - Logs bekijken
kubectl logs deployment/my-app -n default

---
# g4 - Restart deployment
kubectl rollout restart deployment/my-app -n default

---
# g5 - Rollout status
kubectl rollout status deployment/my-app -n default

---
# 1-1a Deployment-Maak manifest
kubectl create deployment my-app-deployment --image nginx --replicas=4 --dry-run=client --output=yaml > my-app-deployment.yaml

---
# 1-1b Deployment-Deploy
kubectl apply -f my-app-deployment.yaml

---
# 1-2 Tonen nodes
kubectl get nodes

---
# 1-3a Verwijder deployment
kubectl delete deploy my-app-deployment

---
# 1-3b Set taint - NoSchedule
kubectl taint nodes desktop-worker desktop-worker2 key1=value1:NoSchedule

---
# 1-3b Verwijder taint - NoSchedule
kubectl taint nodes desktop-worker desktop-worker2 key1=value1:NoSchedule-

---
# 3-1a Rolling update uitvoeren - Namespace demo maken
kubectl apply -f demo/01-namespace.yml

---
# 3-1b Rolling update uitvoeren - v1 deployen
kubectl apply -f demo/03-deployment-v1.yml

---
# 3-1c Rolling update uitvoeren - v2 deployen
kubectl apply -f demo/03-deployment-v2.yml

---
# 3-2 Rollout status volgen
kubectl rollout status deployment/webapp -n demo

---
# 3-3a Rollout geschiedenis bekijken - History bekijken
kubectl rollout history deployment/webapp -n demo

---
# 3-3b Rollout geschiedenis bekijken - Replicas bekijken
kubectl get replicasets -n demo

---
# 3-4a Rollback uitvoeren - Lets go
kubectl rollout undo deployment/webapp -n demo

---
# 3-4b Rollback uitvoeren - Controle oude versie
kubectl get pods -n demo -o jsonpath='{.items[*].spec.containers[*].image}'

---
# 4-1a Cluster IP aanmaken - Service maken
kubectl apply -f demo/04-service-clusterip.yml

---
# 4-1b Cluster IP aanmaken - Service bekijken 1
kubectl get services -n demo

---
# 4-1c Cluster IP aanmaken - Service bekijken 2
kubectl describe service webapp-service -n demo

---
# 4-2 DNS en Endpoints inspecteren
kubectl get endpoints webapp-service -n demo

---
# 4-3a Service bereiken vanuit testpod - Testpod maken
kubectl apply -f demo/06-testpod.yml

---
# 4-3b Service bereiken vanuit testpod - Testpod bereiken
kubectl exec -n demo testpod -- curl -s webapp-service.demo.svc.cluster.local








