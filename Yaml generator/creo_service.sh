#This project is being developed and maintained by Suyesh Singh.
#Commit no. 05
#Commit date 08 Jan 2023

echo "Please enter the namespace(Please do not use just plain numbers as namespace, if you do so yaml file will not be applied.): "
echo "then press[ENTER]:"
read namespace

echo "Please enter a name for your service"
read service_name

echo "is your service dicoverable? Enter y for true and any other key for false"
read -p "Enter your choice. Yes(y) No(any other key) " choice
if [ "$choice" = "y" ]; then
$dicover = true
else 
$discover = false
cat >> $service_name-$namespace.yaml <<EOF
apiVersion: v1
kind: Service
metadata:
  name: $service_name
  namespace: $namespace
  annotations:
    isDiscoverable: '$discover'
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
