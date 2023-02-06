# crowdstrike-interview

## Hi, and thank you for giving me the chance to interview with you!

![Crowdstrike GIF](https://images.squarespace-cdn.com/content/v1/522ea6f5e4b074ba686e497c/1457886542240-GWBCX6C7PKO86N2WR479/bird_monitor.jpg?format=350w)

I am hosting a copy of my resume at https://crowdstrike-interview.zachantinelli.me as a demo of some of the concepts from the job description.

## Here are the resources used in this demo:

- Docker container created from Dockerfile that is running ubuntu and nginx
    - Uploaded to ECR using Docker hub / AWS cli
- AWS ECS cluster (fargate) using Docker container image from ECR
    - Deployed with Terraform
- DNS With AWS Route 53
- Using Cloudflare for CDN