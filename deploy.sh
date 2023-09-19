docker build -t ladka6/multi-client:latest -t ladka6/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ladka6/multi-server:latest -t ladka6/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ladka6/multi-worker:latest -t ladka6/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ladka6/multi-client:latest
docker push ladka6/multi-server:latest
docker push ladka6/multi-worker:latest

docker push ladka6/multi-client:$SHA
docker push ladka6/multi-server:$SHA
docker push ladka6/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ladka6/multi-server:$SHA
kubectl set image deployments/client-deployment client=ladka6/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ladka6/multi-worker:$SHA