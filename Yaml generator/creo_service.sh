#This project is being developed and maintained by Suyesh Singh.
#Commit no. 04
#Commit date 08 Jan 2023

echo "Please enter the namespace(Please do not use just plain numbers as namespace, if you do so yaml file will not be applied.): "
echo "then press[ENTER]:"
read namespace

cat >> $service_name-$namespace.yaml <<EOF
apiVersion: v1
kind: Service
metadata:
  name: finpos-configurations
  namespace: finpos-dev
  annotations:
    isDiscoverable: 'true'
    servicePatterns: settings,systems
spec:
  ports:
    - name: http
      protocol: TCP
      port: 8080
      targetPort: 8080
  selector:
    app: finpos-configurations
  type: ClusterIP
EOF
