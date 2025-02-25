Prerequisites
Before you install the Helm chart, you need to create a Kubernetes Secret for accessing your private Docker registry. This secret will store the Docker credentials, which Kubernetes will use to pull the container image from the private registry.

Step 1: Create Docker Registry Secret
To pull container images from a private registry (such as Docker Hub, AWS ECR, or a custom registry), you need to create a Kubernetes Secret of type docker-registry that contains your Docker credentials.

Run the following command to create the secret:
kubectl create secret docker-registry my-docker-registry-secret \
 --docker-server=docker.io \ # Replace with your private registry URL
--docker-username=<username> \ # Replace with your Docker registry username
--docker-password=<password> \ # Replace with your Docker registry password
--docker-email=myemail@example.com # Replace with your email address

Secret Parameters
docker-server: The URL of your Docker registry. For Docker Hub, use docker.io.
docker-username: Your Docker registry username.
docker-password: Your Docker registry password.
docker-email: Your email address associated with the Docker registry.
This command will create a secret called my-docker-registry-secret in your Kubernetes cluster, which will be used to authenticate with the private registry.

Step 2: Install the Helm Chart
After creating the Docker registry secret, you can proceed with deploying your Helm chart. The chart will reference the created secret for image pulling.

    helm install my-release ./mychart --set image.repository=myregistry.com/my-app --set image.tag=latest

This will install the chart and ensure that Kubernetes uses the Docker registry secret to pull the image from your private registry.

Step 3: Verify the Deployment
To verify that the image is being pulled successfully and the secret is working, you can check the status of your pods:

        kubectl get pods

If there are any issues, such as authentication errors while pulling the image, you can check the pod's events:

        kubectl describe pod <pod-name>

Look for events related to image pulling, such as:

    Failed to pull image "myregistry.com/my-app:latest": rpc error: code = Unknown desc = failed to pull and unpack image...

Conclusion
Create the Docker registry secret using the kubectl create secret docker-registry command.
Install your Helm chart using the helm install command.
Verify the deployment by checking the pod status to ensure the image was pulled successfully.
If you encounter any issues, check the pod's logs and events for more detailed error messages.

Optional - Troubleshooting
Image Pull Failed: If your pods fail to pull the image, ensure that the secret was created successfully and is referenced correctly in the Helm chart. You can check the secret using the following command:

        kubectl get secret my-docker-registry-secret -o yaml

Secret Not Found: If the secret is not found in the namespace where your Helm release is deployed, you might need to create it in the same namespace or use kubectl apply to recreate it.
