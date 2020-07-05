docker build -t benczekristof/multi-client -f ./client/Dockerfile ./client
docker build -t benczekristof/multi-server -f ./server/Dockerfile ./server
docker build -t benczekristof/multi-worker -f ./worker/Dockerfile ./worker
docker push benczekristof/multi-client:latest
docker push benczekristof/multi-server:latest
docker push benczekristof/multi-worker:latest

docker push benczekristof/multi-client:$SHA
docker push benczekristof/multi-server:$SHA
docker push benczekristof/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=benczekristof/multi-server:$SHA
kubectl set image deployments/client-deployment client=benczekristof/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=benczekristof/multi-worker:$SHA
