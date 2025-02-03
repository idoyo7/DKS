helm repo add bitnami https://charts.bitnami.com/bitnami

# helm install myblog bitnami/wordpress -n wordpress


# helm install myblog bitnami/wordpress -n wordpress --version 22.4.18


helm upgrade --install myblog bitnami/wordpress -n wordpress --version 22.4.18 -f cvalues.yaml



DOMAIN="montkim.org"
WILDCARD_DOMAIN="*.$DOMAIN"

# aws cli 와 jq를 사용해 인증서 ARN 추출 (필요에 따라 수정)
CERT_ARN=$(aws acm list-certificates --output json \
  | jq -r --arg wildcard "$WILDCARD_DOMAIN" '
      .CertificateSummaryList[] 
      | select(.DomainName==$wildcard) 
      | .CertificateArn
    ')

# 예시로 서브도메인을 사용
WEBDOMAIN="word.$DOMAIN"

helm upgrade --install myblog bitnami/wordpress -n wordpress --version 22.4.18 -f cvalues.yaml \
  --set ingress.annotations."alb\.ingress\.kubernetes\.io/certificate-arn"="$CERT_ARN" \
  --set ingress.hostname="$WEBDOMAIN"
