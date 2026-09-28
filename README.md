# Dummy Demo 1 — Complete Terminal Session and Output

This README contains the complete commands and outputs captured during the exercise.

---

cat >> README.md << 'EOF'

alla\@Jyothikas-MacBook-Air dummy-demo1 % docker images | grep dummy-svc

dummy-svc:1.0.0                                                                                                   448d1e9f1cbd        145MB             0B        

alla\@Jyothikas-MacBook-Air dummy-demo1 % kubectl version --client 

Client Version: v1.36.2

Kustomize Version: v5.8.1

alla\@Jyothikas-MacBook-Air dummy-demo1 % kind --version 

kind version 0.33.0

alla\@Jyothikas-MacBook-Air dummy-demo1 % docker run -d --name v1 -p 8081:8080 -e APP_VERSION=v1 -e READY_DELAY_SECONDS=0 dummy-svc:1.0.0

f15a0dc3f209986ea281db66baf8d038cbe21781f786a53f88636bbef442f33f

alla\@Jyothikas-MacBook-Air dummy-demo1 % docker run -d --name v2 -p 8082:8080 -e APP_VERSION=v2 -e READY_DELAY_SECONDS=30 dummy-svc:1.0.0

2b9880d8ad546f42878c11899f4977b9183456478c11d332ac7f03e1703dff4c

alla\@Jyothikas-MacBook-Air dummy-demo1 % docker run -d --name v3 -p 8083:8080 -e APP_VERSION=v3-broken -e NEVER_READY=true dummy-svc:1.0.0

586e0568a3905182b6f81097911f95482344422406d60da10606156eb8113fa8

alla\@Jyothikas-MacBook-Air dummy-demo1 % docker rm -f nifty_sanderson v2

nifty_sanderson

v2

alla\@Jyothikas-MacBook-Air dummy-demo1 % docker run -d --name v2 -p 8082:8080 -e APP_VERSION=v2 -e READY_DELAY_SECONDS=30 dummy-svc:1.0.0

1c0dcb297a27888825d5060e764d4c4d0390824f312afea2517f63015c4215b1

alla\@Jyothikas-MacBook-Air dummy-demo1 % check() {

  date

  for p in 8081 8082 8083; do

    echo "== port $p =="

    for e in health ready version; do

      echo -n "/$e -> "; curl -s -o /dev/null -w "%{http_code}\n" localhost:$p/$e

    done

  done

}

alla\@Jyothikas-MacBook-Air dummy-demo1 % check | tee evidence/direct-checks.txt

Mon Sep 28 18:13:03 IST 2026

\== port 8081 ==

/health -> 200

/ready -> 200

/version -> 200

\== port 8082 ==

/health -> 200

/ready -> 503

/version -> 503

\== port 8083 ==

/health -> 200

/ready -> 503

/version -> 503

alla\@Jyothikas-MacBook-Air dummy-demo1 % sleep 35; check | tee -a evidence/direct-checks.txt

curl -s localhost:8082/version | tee -a evidence/direct-checks.txt

Mon Sep 28 18:14:15 IST 2026

\== port 8081 ==

/health -> 200

/ready -> 200

/version -> 200

\== port 8082 ==

/health -> 200

/ready -> 200

/version -> 200

\== port 8083 ==

/health -> 200

/ready -> 503

/version -> 503

{"version": "v2", "pod": "1c0dcb297a27"}**%**                                                                                                                                                                      alla\@Jyothikas-MacBook-Air dummy-demo1 % cat evidence/direct-checks.txt

Mon Sep 28 18:13:03 IST 2026

\== port 8081 ==

/health -> 200

/ready -> 200

/version -> 200

\== port 8082 ==

/health -> 200

/ready -> 503

/version -> 503

\== port 8083 ==

/health -> 200

/ready -> 503

/version -> 503

Mon Sep 28 18:14:15 IST 2026

\== port 8081 ==

/health -> 200

/ready -> 200

/version -> 200

\== port 8082 ==

/health -> 200

/ready -> 200

/version -> 200

\== port 8083 ==

/health -> 200

/ready -> 503

/version -> 503

{"version": "v2", "pod": "1c0dcb297a27"}**%**                                                                                                                                                                      alla\@Jyothikas-MacBook-Air dummy-demo1 % kubectl get pods 

E0928 18:23:00.589067   14767 memcache.go:265] "Unhandled Error" err="couldn't get current server API group list: the server has asked for the client to provide credentials"

E0928 18:23:01.538096   14767 memcache.go:265] "Unhandled Error" err="couldn't get current server API group list: the server has asked for the client to provide credentials"

E0928 18:23:02.457512   14767 memcache.go:265] "Unhandled Error" err="couldn't get current server API group list: the server has asked for the client to provide credentials"

E0928 18:23:03.789234   14767 memcache.go:265] "Unhandled Error" err="couldn't get current server API group list: the server has asked for the client to provide credentials"

E0928 18:23:04.667168   14767 memcache.go:265] "Unhandled Error" err="couldn't get current server API group list: the server has asked for the client to provide credentials"

error: You must be logged in to the server (the server has asked for the client to provide credentials)

alla\@Jyothikas-MacBook-Air dummy-demo1 % kubectl config get-contexts

CURRENT   NAME                                                                       CLUSTER                                                                  AUTHINFO                                                                 NAMESPACE

          arn\:aws\:eks\:us-east-1:986119050506\:cluster/Cluster-1                       arn\:aws\:eks\:us-east-1:986119050506\:cluster/Cluster-1                     arn\:aws\:eks\:us-east-1:986119050506\:cluster/Cluster-1                     

          arn\:aws\:eks\:us-east-1:986119050506\:cluster/employee-management-cluster     arn\:aws\:eks\:us-east-1:986119050506\:cluster/employee-management-cluster   arn\:aws\:eks\:us-east-1:986119050506\:cluster/employee-management-cluster   

          arn\:aws\:eks\:us-east-1:986119050506\:cluster/hello-world-cluster             arn\:aws\:eks\:us-east-1:986119050506\:cluster/hello-world-cluster           arn\:aws\:eks\:us-east-1:986119050506\:cluster/hello-world-cluster           

          docker-desktop                                                             docker-desktop                                                           docker-desktop                                                           

          employee-aks                                                               employee-aks                                                             clusterUser_employee-rg_employee-aks                                     

\*         jyothikaalla15-dev/api-rm3-7wse-p1-openshiftapps-com:6443/jyothikaalla15   api-rm3-7wse-p1-openshiftapps-com:6443                                   jyothikaalla15/api-rm3-7wse-p1-openshiftapps-com:6443                    jyothikaalla15-dev

alla\@Jyothikas-MacBook-Air dummy-demo1 % kind get clusters

No kind clusters found.

alla\@Jyothikas-MacBook-Air dummy-demo1 % kind create cluster --name demo

Creating cluster "demo" ...

⠊⠁ Ensuring node image (kindest/node\:v1.37.0) 🖼️ ^Rbectl config current-context

 ✓ Ensuring node image (kindest/node\:v1.37.0) 🖼️ 

 ✓ Preparing nodes 📦  

 ✓ Writing configuration 📜 

 ✓ Starting control-plane 🕹️ 

 ✓ Installing CNI 🔌 

 ✓ Installing StorageClass 💾 

Set kubectl context to "kind-demo"

You can now use your cluster with:

kubectl cluster-info --context kind-demo

Have a nice day! 👋

alla\@Jyothikas-MacBook-Air dummy-demo1 % kubectl config current-contexkubectl config current-context

error: unknown command "current-contexkubectl config current-context"

See 'kubectl config -h' for help and examples

alla\@Jyothikas-MacBook-Air dummy-demo1 % kubectl config current-context

kind-demo

alla\@Jyothikas-MacBook-Air dummy-demo1 % kubectl get nodes 

NAME                 STATUS   ROLES           AGE   VERSION

demo-control-plane   Ready    control-plane   49s   v1.37.0

alla\@Jyothikas-MacBook-Air dummy-demo1 % kind load docker-image dummy-svc:1.0.0 --name demo

Image: "dummy-svc:1.0.0" with ID "sha256:448d1e9f1cbde0f96e13899742f5f28205f049d229546d1d34ab599b8fe4f807" not yet present on node "demo-control-plane", loading...

alla\@Jyothikas-MacBook-Air dummy-demo1 % { docker --version; kubectl version --client; kind --version; } 2>&1 | tee evidence/tool-versions.txt

Docker version 29.5.3, build d1c06ef

Client Version: v1.36.2

Kustomize Version: v5.8.1

kind version 0.33.0

alla\@Jyothikas-MacBook-Air dummy-demo1 % kubectl --context kind-demo get pods

No resources found in default namespace.

alla\@Jyothikas-MacBook-Air dummy-demo1 % >....                                                                                                                                                                 

  name: dummy-svc

spec:

  replicas: 2

  minReadySeconds: 5

  progressDeadlineSeconds: 90

  revisionHistoryLimit: 5

  strategy:

    type: RollingUpdate

    rollingUpdate:

      maxUnavailable: 0

      maxSurge: 1

  selector:

    matchLabels:

      app: dummy-svc

  template:

    metadata:

      labels:

        app: dummy-svc

    spec:

      securityContext:

        runAsNonRoot: true

        runAsUser: 10001

      containers:

        - name: app

          image: dummy-svc:1.0.0

          imagePullPolicy: IfNotPresent

          ports:

            - containerPort: 8080

          env:

            - name: APP_VERSION

              value: "v1"

            - name: READY_DELAY_SECONDS

              value: "0"

            - name: NEVER_READY

              value: "false"

          startupProbe:

            httpGet:

              path: /health

              port: 8080

            periodSeconds: 2

            failureThreshold: 15

          readinessProbe:

            httpGet:

              path: /ready

              port: 8080

            periodSeconds: 2

            failureThreshold: 2

          livenessProbe:

            httpGet:

              path: /health

              port: 8080

            periodSeconds: 10

            failureThreshold: 3

          resources:

            requests:

              cpu: 50m

              memory: 32Mi

            limits:

              cpu: 200m

              memory: 64Mi

          securityContext:

            allowPrivilegeEscalation: false

EOF

alla\@Jyothikas-MacBook-Air dummy-demo1 % cat > k8s/service.yaml << 'EOF'

apiVersion: v1

kind: Service

metadata:

  name: dummy-svc

spec:

  type: ClusterIP

  selector:

    app: dummy-svc

  ports:

    - port: 80

      targetPort: 8080

EOF

alla\@Jyothikas-MacBook-Air dummy-demo1 % ls k8s/

deployment.yaml	service.yaml

alla\@Jyothikas-MacBook-Air dummy-demo1 % kubectl --context kind-demo apply -f k8s/

deployment.apps/dummy-svc created

service/dummy-svc created

alla\@Jyothikas-MacBook-Air dummy-demo1 % kubectl --context kind-demo rollout status deployment/dummy-svc --timeout=90s

deployment "dummy-svc" successfully rolled out

alla\@Jyothikas-MacBook-Air dummy-demo1 % kubectl --context kind-demo get pods,svc

NAME                             READY   STATUS    RESTARTS   AGE

pod/dummy-svc-5cd9f5cb46-6sbgk   1/1     Running   0          19s

pod/dummy-svc-5cd9f5cb46-bbfsk   1/1     Running   0          19s

NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE

service/dummy-svc    ClusterIP   10.96.113.142   \<none>        80/TCP    19s

service/kubernetes   ClusterIP   10.96.0.1       \<none>        443/TCP   6m48s

alla\@Jyothikas-MacBook-Air dummy-demo1 % kubectl --context kind-demo get endpointslices

NAME              ADDRESSTYPE   PORTS   ENDPOINTS               AGE

dummy-svc-vv46t   IPv4          8080    10.244.0.6,10.244.0.5   30s

kubernetes        IPv4          6443    172.19.0.2              6m59s

alla\@Jyothikas-MacBook-Air dummy-demo1 % { date; kubectl --context kind-demo get pods,svc,endpointslices -o wide; } | tee evidence/v1-deployed.txt

Mon Sep 28 18:34:05 IST 2026

NAME                             READY   STATUS    RESTARTS   AGE   IP           NODE                 NOMINATED NODE   READINESS GATES

pod/dummy-svc-5cd9f5cb46-6sbgk   1/1     Running   0          60s   10.244.0.5   demo-control-plane   \<none>           \<none>

pod/dummy-svc-5cd9f5cb46-bbfsk   1/1     Running   0          60s   10.244.0.6   demo-control-plane   \<none>           \<none>

NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE     SELECTOR

service/dummy-svc    ClusterIP   10.96.113.142   \<none>        80/TCP    60s     app=dummy-svc

service/kubernetes   ClusterIP   10.96.0.1       \<none>        443/TCP   7m29s   \<none>

NAME                                             ADDRESSTYPE   PORTS   ENDPOINTS               AGE

endpointslice.discovery.k8s.io/dummy-svc-vv46t   IPv4          8080    10.244.0.6,10.244.0.5   60s

endpointslice.discovery.k8s.io/kubernetes        IPv4          6443    172.19.0.2              7m29s

alla\@Jyothikas-MacBook-Air dummy-demo1 % kubectl --context kind-demo run curl-test --rm -it --restart=Never --image=curlimages/curl -- curl -s http\://dummy-svc/version

{"version": "v1", "pod": "dummy-svc-5cd9f5cb46-6sbgk"}All commands and output from this session will be recorded in container logs, including credentials and sensitive information passed through the command prompt.

If you don't see a command prompt, try pressing enter.

Session ended, resume using 'kubectl attach curl-test -c curl-test -n default -i -t' command

pod "curl-test" deleted from default namespace

alla\@Jyothikas-MacBook-Air dummy-demo1 % kubectl --context kind-demo run curl-test --rm -it --restart=Never --image=curlimages/curl -- curl -s http\://dummy-svc/version

{"version": "v1", "pod": "dummy-svc-5cd9f5cb46-bbfsk"}All commands and output from this session will be recorded in container logs, including credentials and sensitive information passed through the command prompt.

If you don't see a command prompt, try pressing enter.

warning: couldn't attach to pod/curl-test, falling back to streaming logs: unable to upgrade connection: container curl-test not found in pod curl-test_default

{"version": "v1", "pod": "dummy-svc-5cd9f5cb46-bbfsk"}pod "curl-test" deleted from default namespace

alla\@Jyothikas-MacBook-Air dummy-demo1 % kubectl --context kind-demo run curl-test --rm -i --restart=Never --image=curlimages/curl -- curl -s http\://dummy-svc/version

{"version": "v1", "pod": "dummy-svc-5cd9f5cb46-6sbgk"}All commands and output from this session will be recorded in container logs, including credentials and sensitive information passed through the command prompt.

If you don't see a command prompt, try pressing enter.

warning: couldn't attach to pod/curl-test, falling back to streaming logs: unable to upgrade connection: container curl-test not found in pod curl-test_default

{"version": "v1", "pod": "dummy-svc-5cd9f5cb46-6sbgk"}pod "curl-test" deleted from default namespace

alla\@Jyothikas-MacBook-Air dummy-demo1 % cat > scripts/traffic-check.sh << 'EOF'

\#!/bin/sh

\# Sends 1 request per second to the Service and prints one CSV line per request.

URL="${URL:-http\://dummy-svc/version}"

echo "timestamp,status,version,pod"

while true; do

  TS=$(date -u +%Y-%m-%dT%H:%M:%SZ)

  BODY=$(curl -s --max-time 2 -w '\n%{http_code}' "$URL")

  RC=$?

  if [ "$RC" -ne 0 ]; then

    echo "$TS,ERR_curl\_$RC,-,-"

  else

    CODE=$(echo "$BODY" | tail -n1)

    JSON=$(echo "$BODY" | head -n1)

    VER=$(echo "$JSON" | sed -n 's/.\*"version": "\\([^"]\*\\)".\*/\1/p')

    POD=$(echo "$JSON" | sed -n 's/.\*"pod": "\\([^"]\*\\)".\*/\1/p')

    echo "$TS,$CODE,${VER:--},${POD:--}"

  fi

  sleep 1

done

EOF

alla\@Jyothikas-MacBook-Air dummy-demo1 % kubectl --context kind-demo create configmap traffic-script --from-file=scripts/traffic-check.sh

configmap/traffic-script created

alla\@Jyothikas-MacBook-Air dummy-demo1 % cat > k8s/client.yaml << 'EOF'

apiVersion: v1

kind: Pod

metadata:

  name: traffic-client

spec:

  restartPolicy: Never

  containers:

    - name: client

      image: curlimages/curl

      command: ["sh", "/scripts/traffic-check.sh"]

      volumeMounts:

        - name: script

          mountPath: /scripts

  volumes:

    - name: script

      configMap:

        name: traffic-script

EOF

alla\@Jyothikas-MacBook-Air dummy-demo1 % 

kubectl --context kind-demo apply -f k8s/client.yaml

pod/traffic-client created

alla\@Jyothikas-MacBook-Air dummy-demo1 % kubectl --context kind-demo wait --for=condition=Ready pod/traffic-client --timeout=60s

pod/traffic-client condition met

alla\@Jyothikas-MacBook-Air dummy-demo1 % kubectl --context kind-demo logs -f traffic-client | tee evidence/traffic.csv

timestamp,status,version,pod

2026-09-28T13:07:59Z,200,v1,dummy-svc-5cd9f5cb46-6sbgk

 Last login: Mon Sep 28 18:39:41 on ttys001

alla\@Jyothikas-MacBook-Air dummy-demo1 % kubectl --context kind-demo get pods -w

NAME                         READY   STATUS    RESTARTS   AGE

dummy-svc-75bd9d97cb-rflj5   1/1     Running   0          2m7s

dummy-svc-75bd9d97cb-xsv7m   1/1     Running   0          90s

traffic-client               1/1     Running   0          6m33s

^C**%**                                                                                                                                                                                                            alla\@Jyothikas-MacBook-Air dummy-demo1 % scripts/summarize.sh evidence/traffic.csv | tee evidence/v2-summary.txt

kubectl --context kind-demo get pods,endpointslices -o wide | tee -a evidence/v2-rollout.txt

total requests: 505

successes (200): 505

failures (non-200 or curl error): 0

\--- version / status counts ---

v2 200 194

v1 200 311

NAME                             READY   STATUS    RESTARTS   AGE     IP            NODE                 NOMINATED NODE   READINESS GATES

pod/dummy-svc-75bd9d97cb-rflj5   1/1     Running   0          4m10s   10.244.0.11   demo-control-plane   \<none>           \<none>

pod/dummy-svc-75bd9d97cb-xsv7m   1/1     Running   0          3m33s   10.244.0.12   demo-control-plane   \<none>           \<none>

pod/traffic-client               1/1     Running   0          8m36s   10.244.0.10   demo-control-plane   \<none>           \<none>

NAME                                             ADDRESSTYPE   PORTS   ENDPOINTS                 AGE

endpointslice.discovery.k8s.io/dummy-svc-vv46t   IPv4          8080    10.244.0.11,10.244.0.12   13m

endpointslice.discovery.k8s.io/kubernetes        IPv4          6443    172.19.0.2                19m

alla\@Jyothikas-MacBook-Air dummy-demo1 % >....                                                                                                                                                                 

    echo "$TS,$CODE,${VER:--},${POD:--}"              

  fi                                                  

  sleep 1                                             

done                                                  

EOF                                                   

alla\@Jyothikas-MacBook-Air dummy-demo1 % kubectl --context kind-demo create configmap traffic-script --from-file=scripts/traffic-check.sh

configmap/traffic-script created                      

alla\@Jyothikas-MacBook-Air dummy-demo1 % cat > k8s/client.yaml << 'EOF'

apiVersion: v1                                        

kind: Pod                                             

metadata:                                             

  name: traffic-client                                

spec:                                                 

  restartPolicy: Never                                

  containers:                                         

    - name: client                                    

      image: curlimages/curl                          

      command: ["sh", "/scripts/traffic-check.sh"]    

      volumeMounts:                                   

        - name: script                                

          mountPath: /scripts                         

  volumes:                                            

    - name: script                                    

      configMap:                                      

        name: traffic-script                          

EOF                                                   

alla\@Jyothikas-MacBook-Air dummy-demo1 %              

kubectl --context kind-demo apply -f k8s/client.yaml  

pod/traffic-client created                            

alla\@Jyothikas-MacBook-Air dummy-demo1 % kubectl --context kind-demo wait --for=condition=Ready pod/traffic-client --timeout=60s

pod/traffic-client condition met                      

alla\@Jyothikas-MacBook-Air dummy-demo1 % kubectl --context kind-demo logs -f traffic-client | tee evidence/traffic.csv

timestamp,status,version,pod                          

2026-09-28T13:07:59Z,200,v1,dummy-svc-5cd9f5cb46-6sbgk

2026-09-28T13:08:00Z,200,v1,dummy-svc-5cd9f5cb46-6sbgk

2026-09-28T13:08:01Z,200,v1,dummy-svc-5cd9f5cb46-6sbgk

2026-09-28T13:08:02Z,200,v1,dummy-svc-5cd9f5cb46-bbfsk

2026-09-28T13:08:03Z,200,v1,dummy-svc-5cd9f5cb46-6sbgk

2026-09-28T13:08:04Z,200,v1,dummy-svc-5cd9f5cb46-6sbgk

2026-09-28T13:08:05Z,200,v1,dummy-svc-5cd9f5cb46-bbfsk

2026-09-28T13:08:06Z,200,v1,dummy-svc-5cd9f5cb46-6sbgk

2026-09-28T13:08:07Z,200,v1,dummy-svc-5cd9f5cb46-6sbgk

2026-09-28T13:08:08Z,200,v1,dummy-svc-5cd9f5cb46-bbfsk

2026-09-28T13:08:09Z,200,v1,dummy-svc-5cd9f5cb46-bbfsk

2026-09-28T13:08:10Z,200,v1,dummy-svc-5cd9f5cb46-6sbgk

2026-09-28T13:08:11Z,200,v1,dummy-svc-5cd9f5cb46-bbfsk

2026-09-28T13:08:12Z,200,v1,dummy-svc-5cd9f5cb46-6sbgk

2026-09-28T13:08:13Z,200,v1,dummy-svc-5cd9f5cb46-bbfsk

2026-09-28T13:08:14Z,200,v1,dummy-svc-5cd9f5cb46-bbfsk

2026-09-28T13:08:15Z,200,v1,dummy-svc-5cd9f5cb46-bbfsk

2026-09-28T13:08:16Z,200,v1,dummy-svc-5cd9f5cb46-6sbgk

2026-09-28T13:08:17Z,200,v1,dummy-svc-5cd9f5cb46-bbfsk

2026-09-28T13:08:18Z,200,v1,dummy-svc-5cd9f5cb46-6sbgk

2026-09-28T13:08:19Z,200,v1,dummy-svc-5cd9f5cb46-bbfsk

2026-09-28T13:08:21Z,200,v1,dummy-svc-5cd9f5cb46-bbfsk

2026-09-28T13:08:22Z,200,v1,dummy-svc-5cd9f5cb46-6sbgk

2026-09-28T13:08:23Z,200,v1,dummy-svc-5cd9f5cb46-bbfsk

2026-09-28T13:08:24Z,200,v1,dummy-svc-5cd9f5cb46-bbfsk

2026-09-28T13:08:25Z ,200,v1,dummy-svc-5cd9f5cb46-bbfsk

EOF        