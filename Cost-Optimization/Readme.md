# **AWS Billing Optimization Playbook**

## **Author: Harendra Barot**
### **Date: 14-11-2024**
________________________________________
**1. Overview	
Purpose:**
To optimize AWS costs using a real-world approach and document actionable steps for sustained savings.

**Target Audience:** 
Beginners and intermediate AWS users who want to analyse, identify, and minimize AWS billing inefficiencies.

**Expected Outcome:**
Learn how to evaluate billing trends, identify unnecessary expenses, and implement cost-saving measures effectively.
________________________________________
**2. Current Scenario
Description:**
**Overview of AWS usage and billing data for the past two months:**

-	**Month 1 Bill: $46**
      -	Primary Contributors:
        - Amazon Business Support: $41
        - VPC Services: $5.85
    	
-	**Month 2 Bill: $100**  
      -	Primary Contributors:	
        - Amazon Business Support: $41
        - VPC Services: $5
        - Additional service charges: ~$54
  
**Resource List:**

•	Compute: EC2 Instances (usage unknown).

•	Networking: Virtual Private Cloud (VPC) services.

•	Storage: S3 and Elastic Block Storage (EBS).

•	Support Plan: Amazon Business Support.
________________________________________

**3. Step-by-Step Approach to Cost Optimization** 

**3.1. Analyse the Bill**

**- Action Items:**
      **1.	Review AWS Cost Explorer to categorize charges by service, region, and time period.**
      **2.  Identify significant contributors to costs, such as high NAT Gateway or data transfer charges.**
      
      -Tools: AWS Cost Explorer, Billing Dashboard.
      - Outcome: Clear visibility of cost breakdown and trends.
________________________________________
**3.2. Audit Resources**

**Action Items:**

   - 1.Inventory all active resources using AWS Resource Groups and Trusted Advisor.
   - 2.Identify underutilized or idle resources, such as:
     
      -	Unused EC2 instances or Lambda functions.
      -	Unattached EBS volumes or old snapshots.
      -	Idle Elastic IPs or NAT Gateways.
**Tools:** AWS Resource Groups, AWS Trusted Advisor, AWS CLI.
**Outcome:** A detailed list of resources for potential cleanup or optimization.
________________________________________
**3.3. Optimize Specific Services**

**Examples:**

**1.	Amazon Business Support:** 

   - Problem: High monthly cost ($41).
   - Resolution: Downgrade to Developer Support if business-level SLA is unnecessary.
   	
**2.	VPC Services:**

    - Problem: High NAT Gateway charges.
    - Resolution: Replace NAT Gateway with NAT Instances or consider consolidating traffic to reduce costs.
      	
**3.	Compute (EC2):** 

   - Problem: Possible oversized or unused instances.
   - Resolution: Right-size instances or switch to Spot Instances for non-critical workloads.
   
**4.	S3 Storage:**

  - Problem: Increased storage costs due to old or infrequently accessed data.
  - Resolution: Implement lifecycle policies to transition data to S3 Glacier.
________________________________________
**3.4. Automate Resource Clean-up**

**Action Items:** 
**1.	Schedule regular clean-up tasks for:**
   -	Unused resources (e.g., unattached EBS volumes).
   -	Idle EC2 instances or stopped instances.
     
**2.	Use scripts to automate these tasks.**
  - Tools: AWS Lambda, AWS Instance Scheduler, AWS CLI.
  - Outcome: Proactive resource management and reduced costs.
________________________________________
**3.5. Budget and Alerts**

**Action Items:**
  1.	Set up AWS Budgets for specific services or total monthly spend.
  2.	Create alerts for threshold breaches to avoid unexpected charges.
     
**Outcome:** Real-time notifications for cost management.
________________________________________
**4. Real-Time Optimization Examples**
Example 1: Reducing VPC Costs
•	Scenario: Monthly NAT Gateway charges of $5.
•	Problem: High cost for limited usage.
•	Solution: Switched to NAT Instances, reducing costs by $3/month.

Example 2: Managing S3 Storage Costs
•	Scenario: Growing S3 costs from old data storage.
•	Problem: Infrequently accessed data in Standard storage class.
•	Solution: Transitioned 50 GB to Glacier, saving ~$10/month.
________________________________________
**5. Tools and Scripts**

**•	Tools Used:** 
    -	AWS Cost Explorer for bill analysis.
    -	AWS Trusted Advisor for resource auditing.
    -	AWS Lambda and CLI for automation.
**•	Sample Script:**

**Automating cleanup of unattached EBS volumes:**

> aws ec2 describe-volumes --query 'Volumes[?State==`available`].[VolumeId]' \
> --output text | xargs -I {} aws ec2 delete-volume --volume-id {} 
________________________________________
**6. Lessons Learned** 

1.	Regular audits are essential to identify unused resources.
2.	Automating clean-up tasks saves time and avoids human error.
3.	Downgrading unnecessary services (like support plans) can lead to significant savings.
________________________________________
**7. Best Practices** 

1.	**Tag Resources:** Use consistent tags for tracking and identifying project-specific resources.
2.	**Enable Monitoring:** Use CloudWatch to track resource usage.
3.	**Consolidate Regions:** Minimize cross-region data transfer to reduce costs.
4.	**Optimize Storage:** Implement S3 lifecycle policies and remove unused snapshots.
________________________________________
**8. Appendices**

**•	Glossary:** Define AWS terms like NAT Gateway, Spot Instances, and S3 Lifecycle Policies.


**•	Screenshots:**  
	 ![My-cloud-Bill](https://github.com/user-attachments/assets/443c9476-07f5-42da-a9be-769a45db032c)
  ![My-Business-Support](https://github.com/user-attachments/assets/45fb6aa8-432f-4bcf-8ae3-10efefb6889b)

**•	References:** https://docs.aws.amazon.com/cost-management/latest/userguide/what-is-costmanagement.html

