
## Ansible and Terraform Project for Website Deployment

This project utilizes Ansible and Terraform to automate the deployment of a website on a DigitalOcean server. The project encompasses the following tasks:

1.  **Provisioning a DigitalOcean Server:** Terraform is employed to provision a DigitalOcean server, defining its instance type, region, and other relevant configurations.
    
2.  **Setting Up Domain IP:** The server's IP address is retrieved and configured for the website's domain in Cloudflare, ensuring proper DNS resolution.
    
3.  **Installing Nginx Web Server:** Ansible is used to install the Nginx web server on the provisioned server, preparing it to host the website.
    
4.  **Uploading Website Files:** The website's files are uploaded to the server's designated directory, making the website content accessible.
    
5.  **Acquiring SSL Certificate:** An SSL certificate is obtained for the website's domain, ensuring secure communication with visitors.
    
6.  **Enabling TLS 1.3:** TLS 1.3, the latest and most secure encryption protocol, is enabled on the Nginx server, enhancing website security.
    
7.  **Starting the Website:** The Nginx web server is configured and started, making the website accessible to users through the configured domain.
    

**Prerequisites:**

-   Terraform and Ansible installed and configured
-   DigitalOcean account with API access
-   Cloudflare account with DNS management enabled

**Instructions:**

1.  **Clone the Project Repository:** Clone the project repository to your local machine.
    
2.  **Initialize Terraform:** Navigate to the project directory and initialize Terraform using the command `terraform init`.
    
3.  **Apply Terraform Configuration:** Apply the Terraform configuration to provision the DigitalOcean server using the command `terraform apply`. Ansible will be executed automatically **after infrastructure provisioning**.
    
4.  **Access the Website:** Once the Ansible playbook completes successfully, access the website using the configured domain.
    

**Additional Notes:**

-   The project's configuration files (Terraform and Ansible playbooks) need to be customized with specific values for your DigitalOcean instance, Cloudflare domain, and website files.
-   Ensure proper authentication credentials are set up for Terraform to access the DigitalOcean API and for Ansible to connect to the provisioned server and for Cloudflare to set up domain IP.

This project provides a streamlined approach to website deployment using Ansible and Terraform, automating the infrastructure provisioning, configuration, and website setup. By leveraging these tools, you can efficiently manage and maintain your website infrastructure.
