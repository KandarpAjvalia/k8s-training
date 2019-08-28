docker build -t kajvalia/multi-client:latest -t kajvalia/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kajvalia/multi-server:latest -t kajvalia/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kajvalia/multi-worker:latest -t kajvalia/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push kajvalia/multi-client:latest
docker push kajvalia/multi-server:latest
docker push kajvalia/multi-worker:latest

docker push kajvalia/multi-client:$SHA
docker push kajvalia/multi-server:$SHA
docker push kajvalia/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=kajvalia/multi-server:$SHA
kubectl set image deployments/client-deployment client=kajvalia/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kajvalia/multi-worker:$SHA