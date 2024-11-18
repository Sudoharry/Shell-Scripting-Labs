## STOPPING EC2 INSTANCES
To create a shell script that can stop either specific EC2 instances or all EC2 instances, you can modify the script to handle both use cases. Here’s how you can structure it:

##  Goals:
- Stop all EC2 instances: The script will list all running EC2 instances and stop them.
- Stop specific EC2 instances: You can specify instance IDs in the script to stop them individually.

### Script Overview:
- Option 1: Stop all running EC2 instances.
- Option 2: Stop specific EC2 instances (based on provided instance IDs).

### Steps to Create the Script:
- Create the Shell Script: Open a text editor to create a new shell script. We’ll name it stop_ec2_instances.sh.
     - nano stop_ec2_instances.sh

 ### Functions:

  - stop_all_instances: This function lists all running EC2 instances and stops them.
  - stop_specific_instances: This function stops specific instances based on the instance IDs provided as input (comma-separated).
  - The script asks the user whether they want to stop all instances or specific instances. Based on the input, the appropriate function is called.
  - Choice Handling: If the user selects option 1, all running EC2 instances will be stopped. If the user selects option 2, they will be prompted to 
    enter instance IDs to stop.

### Make the Script Executable: 
   - After saving the script, make it executable by running:
      - chmod 700 stop_ec2_instances.sh
    
### Run the Script: Now, you can run the script to stop EC2 instances:
       - When you run the script, it will display a prompt asking if you want to stop all EC2 instances or specific EC2 instances. 
        Based on your choice, the corresponding action will be taken.
![Output](https://github.com/user-attachments/assets/4a1797d5-2a1b-42d1-8252-fa0c25f75353)

       
