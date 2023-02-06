# crowdstrike-interview

![Crowdstrike GIF](https://www.nativegd.com/crowdstrike1)

## Hi, and thank you for giving me the chance to interview with you.

### Here are the resources used in this demo:

- Docker container created from Dockerfile that is running ubuntu and nginx
    - Uploaded to ECR using Docker hub / AWS cli
- AWS ECS cluster (fargate) using Docker container image from ECR
    - Deployed with Terraform
- DNS With AWS Route 53
- Using Cloudflare for CDN