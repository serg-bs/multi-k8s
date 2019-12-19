docker build -t serg-bs/multi-client:latest -t serg-bs/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t serg-bs/multi-server:latest -t serg-bs/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t serg-bs/multi-worker:latest -t serg-bs/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push serg-bs/multi-client:latest
docker push serg-bs/multi-server:latest
docker push serg-bs/multi-worker:latest

docker push serg-bs/multi-client:$SHA
docker push serg-bs/multi-server:$SHA
docker push serg-bs/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=serg-bs/multi-server:$SHA
kubectl set image deployments/client-deployment client=serg-bs/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=serg-bs/multi-worker:$SHA