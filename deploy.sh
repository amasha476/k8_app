docker build -t amasha97/client_image:latest -t amasha97/client_image:$SHA -f ./client/Dockerfile ./client
docker build -t amasha97/server_image:latest -t amasha97/server_image:$SHA -f ./server/Dockerfile ./server
docker build -t amasha97/worker_image:latest -t amasha97/worker_image:$SHA -f ./worker/Dockerfile ./worker

docker push amasha97/client_image:latest
docker push amasha97/server_image:latest
docker push amasha97/worker_image:latest

docker push amasha97/client_image:$SHA
docker push amasha97/server_image:$SHA
docker push amasha97/worker_image:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=amasha97/server_image:$SHA
kubectl set image deployments/client-deployment client=amasha97/client_image:$SHA
kubectl set image deployments/worker-deployment worker=amasha97/worker_image:$SHA