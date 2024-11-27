# System-Usage-Time-Tracking

Create a Script File:
Open a terminal and create a new script file in your home directory:
bash
nano ~/laptop_usage.sh
Paste the Code
Make the Script Executable:
After saving the file, make it executable with the following command:
bash
chmod +x ~/laptop_usage.sh

Step 2: Create a Systemd Service
Create a Systemd Service File:
Create a new service file for your script:
bash
sudo nano /etc/systemd/system/laptop_usage.service

Add Service Configuration:
Add the following configuration to the service file:
text

[Unit]
Description=Laptop Usage Logger
After=multi-user.target

[Service]
Type=simple
ExecStart=/bin/bash /home/your_username/laptop_usage.sh
User=your_username
Environment=HOME=/home/your_username

[Install]
WantedBy=multi-user.target

Step 3: Enable and Start the Service
Reload Systemd Daemon:
After creating the service file, reload the systemd manager configuration:
bash
sudo systemctl daemon-reload

Enable the Service:
Enable the service so that it starts on boot:
bash
sudo systemctl enable laptop_usage.service

Step 4: Verify the Service
To check if your service is running correctly, you can use:
bash
sudo systemctl status laptop_usage.service

Step 5: Run the Code
./laptop_usage.sh
