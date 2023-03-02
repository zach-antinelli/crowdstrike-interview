# crowdstrike-interview

## Hi, and thank you for giving me the chance to interview with you!

![Crowdstrike GIF](https://images.squarespace-cdn.com/content/v1/522ea6f5e4b074ba686e497c/1457886542240-GWBCX6C7PKO86N2WR479/bird_monitor.jpg?format=300w)

I am hosting a copy of my resume at https://crowdstrike-interview.zachantinelli.me and a guestbook web app at https://crowdstrike-interview-eks.zachantinelli.me:3000 as a demo of some of the concepts from the job description.

## Resources used for demo sites:

https://crowdstrike-interview.zachantinelli.me
- AWS ECS cluster (fargate) using Docker container image from ECR
    - Deployed with Terraform
- Docker container created from Dockerfile that is running ubuntu and nginx
    - Uploaded to ECR using Docker hub / AWS cli
- Route 53 DNS

https://crowdstrike-interview-eks.zachantinelli.me:3000
- Amazon EKS k8s cluster 
    - Deployed with AWS CLI and kubectl
    - Web frontend 
    - Redis backend
    - Docker containers
- Route 53 DNS