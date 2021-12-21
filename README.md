# Remote-DevContainers-Extras
Extras to show how DevContainers and Codespaces can be used for remote development with resources behind the firewall

# Options
1) Plain and simple use the SSH remote extension in VS Code. No code to show in here but worth highlighting as an option.
2) Codespace with a VPN into the network :smile:
3) SSH extension for VS code with a twist. Remote host is Linux with Docker installed. Run DevContainer on remote host. 



# Setup Walkthrough
## Host / Remote VM
- Creates a ssh key pair for connecting to the VM via VS Code.
- Create a linux VM with docker installed (link: https://docs.docker.com/engine/install/ubuntu/)  
  ```bash
    sudo apt-get update

    sudo apt-get install \
	    ca-certificates \
	    curl \
	    gnupg \
        lsb-release

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io 
    
  ```
- Make sure the user has the correct access to docker.
  ```bash
    sudo usermod -aG docker $USER
  ```

## Client
- Install VS Code
- Install the **Remote Development** extension:  
![Remote Development Extension](images/Remote-Development%20Extension.png)    
- Copy the private key into **.ssh** folder
- Setup ssh-agent in PowerShell
  ```powershell
    set-service ssh-agent -startuptype "Automatic"
    start-service ssh-agent
    ssh-add C:\Users\<user>\.ssh\<keyname>
  ```
  If you get errors connecting to the DevContainer (e.g. Crypto Errors) Upgrade the ssh agent. The following Powershell with find the latest zip file links:  
  ```powershell
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $url = 'https://github.com/PowerShell/Win32-OpenSSH/releases/latest/'
    $request = [System.Net.WebRequest]::Create($url)
    $request.AllowAutoRedirect=$false
    $response=$request.GetResponse()
    $([String]$response.GetResponseHeader("Location")).Replace('tag','download') + '/OpenSSH-Win64.zip'  
    $([String]$response.GetResponseHeader("Location")).Replace('tag','download') + '/OpenSSH-Win32.zip'
  ```
- Optional: Install Docker Extension for visibility of the containers and images created  
    ![Docker Externsion](images/docker%20extension.png)
  
## Process to connect to DevContainer
- Connect to the remote host using ssh (e.g. azureuser@1.2.45.6)  
  ![SSH to Remote Host](images/ssh%20to%20host.png)
- On the remote VM clone a repo (e.g. git clone ……)
- Run command : Remote-Containers: Open Folder in container
- Select the folder you want and VS Code will create/open the devcontainer on the remote VM.  
  ![DevContainer](images/devcontainer.png)


