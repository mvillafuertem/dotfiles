#!/usr/bin/env bash
alias ll='ls -lah'
alias v-='vi -'
alias ..='cd .. && ll'
alias .-='cd - && ll'
alias ..2='cd ../..'
alias desk='cd ~/Desktop'
alias gitlab='cd ~/Projects/Gitlab'
alias oa='atom .'
alias of='open .'
alias oi='idea .'
alias projects='cd ~/Projects'
alias newproject='mkdir -p src/{main,test}/{java,resources} src/main/java/com/mvillafuertem'
alias workspace='cd ~/Workspace'
alias ppwd='cd `pbpaste`'
alias hound='grep -Hrn --color'

### Sbt ###
alias sbtdu='sbt dependencyUpdates'
alias sbtct='sbt clean test'
alias sbtfast='sbt clean fastOptJS'

### Gradle ###
alias galias="cat ~/.bash_aliases | grep gradlew"
alias gdlcb='./gradlew clean build'
alias gdltc='./gradlew test --continuous'
alias gdltj='./gradlew test jacocoTR --continuous'

### Maven ###
alias malias="cat ~/.bash_aliases | grep mvn"
alias mvncc='mvn clean compile'
alias mvnci='mvn clean install'
alias mvncis='mvn clean install -Dmaven.test.skip'
alias mvnco='mvn clean test cobertura:cobertura'
alias mvnct='mvn clean test'
alias mvncto='mvn -o clean test'
alias mvnda='mvn dependency:analyze'
alias mvndl='mvn dependency:list'
alias mvndt='mvn dependency:tree'
alias mvndu='mvn versions:display-dependency-updates'
alias mvnpu='mvn versions:display-plugin-updates'
alias mvnsr='mvn surefire-report:report'
alias mvnso='mvn sonar:sonar'

### VirtualBox ###
alias vbox-start='VBoxManage startvm ubuntu -type headless'
alias vbox-stop='VBoxManage controlvm ubuntu poweroff'
alias vbox-list='VBoxManage list vms'

### Docker ###
alias dkalias="cat ~/.bash_aliases | grep docker"
alias dkl='docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}\t{{.Names}}"'
alias dkx='docker exec -it --user root'
alias dkamm='docker run --rm -it --entrypoint /bin/bash -v `pwd`:/root/app mvillafuertem/scala-amm'
alias dksbt='docker run --rm -it --entrypoint /bin/bash -v `pwd`:/root/app mvillafuertem/scala-sbt'
alias dkaws='docker run --rm -it --entrypoint /bin/bash -v ~/.aws:/root/.aws amazon/aws-cli:2.0.7'
alias rcli="docker run --rm -it alpine sh -c 'apk --update add redis && sh'"
alias pcli="docker run --rm -it alpine sh -c 'apk --update add postgresql-client && sh'"
alias kman='_docker_kafka_manager() { docker run -p 9000:9000 -e APPLICATION_SECRET=letmein -e KM_ARGS=-Djava.net.preferIPv4Stack=true -e ZK_HOSTS="$1" sheepkiller/kafka-manager:latest ;}; _docker_kafka_manager'
### Kubernetes ###
alias kalias="cat ~/.bash_aliases | grep kubectl"
alias klogs="kubectl logs -f"
alias kpod="kubectl describe pod"
alias kapply="kubectl apply -f"
alias kdel="kubectl delete"
alias kpods="kubectl get pods --output=wide"
alias kpods-r="kubectl get pods --field-selector=status.phase=Running"
alias kpods-f="kubectl get pods --field-selector=status.phase=Failed"
alias kwatch="kubectl get pods -w"
alias ksvc="kubectl describe service"
alias ksvcs="kubectl get service --output=wide"
alias kpvcs="kubectl get PersistentVolumeClaim"
alias kpvc="kubectl describe PersistentVolumeClaim"
alias krol="kubectl get roles"
alias kcmaps="kubectl describe configmaps"
alias kns="kubectl config set-context --current --namespace"
alias kctx="kubectl config use-context"
alias kctxs="kubectl config get-contexts"
alias kdeploys="kubectl get deploy --output=wide"
alias kdeploy="kubectl describe deploy"
alias kcms="kubectl get configmaps"
alias kcm="kubectl describe configmap"
alias kall="kubectl get all"
alias kdes="kubectl describe"
alias kbusybox="kubectl run busybox -it --rm --restart=Never --image=busybox -- "
alias kget="kubectl get"
alias kexec="kubectl exec -it"
alias ktail="kubetail"
alias kalpine="kubectl run alpine --image=alpine --restart=Never --rm -it sh"

### Google Cloud ###
alias gcloudalias="cat ~/.bash_aliases | grep gcloud"
alias gcluster="gcloud container clusters list"
alias gprojects="gcloud projects list"
alias gprojectset="gcloud config set project"

### CICD  ###
alias cid="./.cicd/deploy.sh"
alias cit="./.cicd/test.sh"
alias cib="./.cicd/build.sh"
alias cir="./.cicd/release.sh"

