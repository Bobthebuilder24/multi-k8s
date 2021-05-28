docker build -t bobthebuilder24/multi-client:latest -t bobthebuilder24/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bobthebuilder24/multi-server:latest -t bobthebuilder24/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bobthebuilder24/multi-worker:latest -t bobthebuilder24/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bobthebuilder24/multi-worker:$SHA
docker push bobthebuilder24/multi-server:$SHA
docker push bobthebuilder24/multi-client:$SHA

docker push bobthebuilder24/multi-worker:latest
docker push bobthebuilder24/multi-server:latest
docker push bobthebuilder24/multi-client:latest

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bobthebuilder24/multi-server:$SHA
kubectl set image deployments/client-deployment client=bobthebuilder24/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=bobthebuilder24/multi-worker:$SHA