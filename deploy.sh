docker build -t \
       ecarlste/react-fibonacci-kubernetes-client:latest \
       ecarlste/react-fibonacci-kubernetes-client:$GIT_SHA \
       ./client/Dockerfile \
       ./client

docker build -t \
       ecarlste/react-fibonacci-kubernetes-api:latest \
       ecarlste/react-fibonacci-kubernetes-api:$GIT_SHA \
       ./api/Dockerfile \
       ./api

docker build -t \
       ecarlste/react-fibonacci-kubernetes-worker:latest \
       ecarlste/react-fibonacci-kubernetes-worker:$GIT_SHA \
       ./worker/Dockerfile \
       ./worker

docker push ecarlste/react-fibonacci-kubernetes-client
docker push ecarlste/react-fibonacci-kubernetes-api
docker push ecarlste/react-fibonacci-kubernetes-worker

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=ecarlste/react-fibonacci-kubernetes-client:$GIT_SHA
kubectl set image deployments/api-deployment api=ecarlste/react-fibonacci-kubernetes-api:$GIT_SHA
kubectl set image deployments/worker-deployment worker=ecarlste/react-fibonacci-kubernetes-worker:$GIT_SHA