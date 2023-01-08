#This project is being developed and maintained by Suyesh Singh.
#Commit no. 09
#Commit date 08 Jan 2023

echo "Please enter the namespace(Please do not use just plain numbers as namespace, if you do so yaml file will not be applied.): "
echo "then press[ENTER]:"
read namespace

echo "Please enter ingress name:"
read ingress_name

#echo "Creating namespace $namespace. " #Enable this for testing purpose only.

#kubectl create ns $namespace #Enable this for testing purpose only.
cat >> $ingress_name-$namespace.yaml <<EOF
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: $ingress_name
  namespace: $namespace
  annotations:
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/add-base-url: 'true'
    nginx.ingress.kubernetes.io/configuration-snippet: |
      more_set_headers "server: hide";
      more_set_headers "X-Content-Type-Options: nosniff";
      more_set_headers "X-Frame-Options: DENY";
      more_set_headers "X-Xss-Protection: 1";
    nginx.ingress.kubernetes.io/hsts: 'True'
    nginx.ingress.kubernetes.io/hsts-include-subdomains: 'True'
    nginx.ingress.kubernetes.io/proxy-body-size: '0'
    nginx.ingress.kubernetes.io/proxy-buffer-size: 24k
    nginx.ingress.kubernetes.io/proxy-connect-timeout: 600s
    nginx.ingress.kubernetes.io/proxy-hide-header: Server
    nginx.ingress.kubernetes.io/proxy-read-timeout: 600s
    nginx.ingress.kubernetes.io/rewrite-target: /$2
    nginx.ingress.kubernetes.io/server-tokens: 'False'
    nginx.ingress.kubernetes.io/ssl-ciphers: >-
      ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384
    nginx.ingress.kubernetes.io/ssl-prefer-server-ciphers: 'true'
    nginx.ingress.kubernetes.io/ssl-protocols: TLSv1.2 TLSv1.3
    nginx.ingress.kubernetes.io/ssl-redirect: 'true'

spec:
  tls:
    - hosts:
        - citytech.global
      secretName: new-citytech-cert
  rules:
    - host: dev.citytech.global
      http:
        paths:
          - path: /grafana(/|$)(.*)
            pathType: ImplementationSpecific
            backend:
              service:
                name: loki-stack-grafana
                port:
                  number: 80
EOF
