# terraform 환경 변수 저장
export TF_VAR_KeyName=[각자 ssh keypair]
echo $TF_VAR_KeyName

# 
terraform init
terraform plan

# 10분 후 배포 완료
terraform apply -auto-approve

# EKS 클러스터 인증 정보 업데이트
CLUSTER_NAME=myeks
aws eks update-kubeconfig --region ap-northeast-2 --name 
$CLUSTER_NAME
kubectl config rename-context "arn:aws:eks:ap-northeast-2:$(aws sts get-caller-identity --query 'Account' --output text):cluster/$CLUSTER_NAME" "DKS"
