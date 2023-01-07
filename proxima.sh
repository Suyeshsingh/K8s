#This project is being developed and maintained by Suyesh Singh.
echo "Please enter the namespace: "
echo "then press[ENTER]:" 
read namespace

echo "Creating namespace $namespace. "

kubectl create ns $namespace

echo "$namespace created."
