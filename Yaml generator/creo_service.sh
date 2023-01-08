#This project is being developed and maintained by Suyesh Singh.
#Commit no. 09
#Commit date 08 Jan 2023

echo "Please enter the namespace(Please do not use just plain numbers as namespace, if you do so yaml file will not be applied.): "
echo "then press[ENTER]:"
read namespace

echo "Please enter a name for your service"
read service_name

echo "is your service dicoverable? Enter y for true and any other key for false"
read -p "Enter your choice. Yes(y) No(any other key) " choice
if [ "$choice" = "y" ]; then
echo "Press enter to continue"
read discover
discover=`echo -n true`

echo "please enter your service pattern, use comma to enter multiple for example setting,system "
read service_pattern
echo "Press  enter to continue"
read service_pattern_key
service_pattern_key=`echo -n servicePatterns:`
else
echo "press enter to continue"
read discover
discover=`echo -n false`
fi

cat >> $service_name-$namespace-service.yaml <<EOF
apiVersion: v1
kind: Service
metadata:
  name: $service_name
  namespace: $namespace
  annotations:
    isDiscoverable: '$discover'
    $service_pattern_key $service_pattern
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

echo "Your service file has been generated. Thank you for using creo."
