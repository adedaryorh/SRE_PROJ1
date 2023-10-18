# Infrastructure

## AWS Zones
Identify your zones here
### Primary site 

Primary side is deployed in zone 1:  US East (Ohio) `us-east-2` in 3 AZ :` us-east-2a`, `us-east-2b` and `us-east-2c`
### DR site 

DR side is deployed in zone 2: US West (N. California)  `us-west-1` in 2 AZ  `us-west-1b` and `us-west-1c`

## Servers and Clusters

### Table 1.1 Summary
| Asset      | Purpose           | Size                                                                   | Qty                                                             | DR                                                                                                           |
|------------|-------------------|------------------------------------------------------------------------|-----------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------|
| Ubuntu-Web | Web server  | `t3.micro` | 3 nodes | deployed to DR |
| Udacity | SSH key pair  |  | 1 key | stored on SRE team member machine |
| udacity-najla | AMI  |  | 1 image | created in multiple locations|
| udacity-pg-p | primary cluster Database  | `db.t2.small` | 2 node | replicated | 
| udacity-pg-s | secondary cluster Database  | `db.t2.small` | 2 node | replicated | 
| eks-udacity-node | EKS node  | `t3.mediuml` | 2 node | deployed to DR |
| ALB | Cloud Load Balancer  |  | 1 ALB | created in multiple regions |
| VPC | Networking blueprint  |  | 1 VPC | deployed to DR  |

### Descriptions

The webserver hosting the application should be deployed to multiple availability zones and have redundancy and adding 3 nodes is ideal.

SSH key pair used to SSH into the web server is an important IT asset.

The customized AMI used to deploy the spin the webserver should be copied in in multiple locations.

The database should be deployed into primary and secondary clusters, having 2 nodes each.

Kubernetes cluster has 2 nodes and should be deployed to DR in another region.

The application load balancer which is the entry point to the application should be deployed in each region.

The VPC representing the networking blueprint has IPs in multiple availability zones.

## DR Plan
### Pre-Steps:
List steps you would perform to setup the infrastructure in the other region. It doesn't have to be super detailed, but high-level should suffice.

Ensure the infrastructure is set up and working in the DR site.
Ensure that the infrastructure as code (IaC) for primary and DR site have no Configuration drift

## Steps:
You won't actually perform these steps, but write out what you would do to "fail-over" your application and database cluster to the other region. Think about all the pieces that were setup and how you would use those in the other region

Point your DNS to your secondary region, to the cloud load balancer so when fail over the single DNS entry at your DNS provider to point to the DR site.

        Edit Route53 to the new ALB provisioned in the DR region


Implement a replicated database and failover your  replication instances to another region

        RDS will automatically promote the Read Replica in the DR region to be the new Regional endpoint in case of failure