#This project is being developed and maintained by Suyesh Singh.
#Commit no. 5
#Commit date 07 Jan 2023

echo "Please enter the namespace(Please do not use just plain numbers as namespace, api version will not read it.): "
echo "then press[ENTER]:"
read namespace

#echo "Creating namespace $namespace. " #Enable this for testing purpose only.

#kubectl create ns $namespace #Enable this for testing purpose only.

echo "Do you want to create a secret?"
read -p "Enter your choice. Yes(y) No(any other key) " choice
if [ "$choice" = "y" ]; then
echo "Creating secret file"

cat >> $namespace-secret.yaml <<EOF

apiVersion: v1
kind: Secret
metadata:
  name: $namespace-secret
  namespace: $namespace
type: Opaque
data:
  USER_NAME: YWRtaW4=
  PASSWORD: MWYyZDFlMmU2N2Rm

EOF

#kubectl apply -f $namespace-secret.yaml #Enable this for testing purpose only.

else
echo "Not creating a secret"
echo "Thank you for using Creo."
fi

