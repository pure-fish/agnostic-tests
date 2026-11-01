---
description: 'Guidelines and conventions for Docker-related scripts and usage'
applyTo: '**/*.Dockerfile'
---

## Docker Instructions

Code conventions for Docker-related scripts and usage within the project.

### General Guidelines

- Use the provided Dockerfiles and Docker Compose configurations for building and running containers.
- Avoid hardcoding paths or versions; rely on environment variables and project-defined constants.
- Ensure that any Docker-related scripts are idempotent and can be safely re-run.

### Testing with Docker

- Use the Docker-backed Make targets for running tests to ensure consistency across environments.
- Verify that Docker containers are built and run correctly using the provided Dockerfiles and Compose configurations.
- Ensure that tests do not depend on the host environment and can run reliably within the Docker container.

### Best Practices

- Keep Dockerfiles simple and focused on a single responsibility.
- Minimize the number of layers in Docker images to improve build performance.
- Use multi-stage builds to reduce the final image size.
- Regularly update base images to incorporate security patches and improvements.

### Conventions

- Name Docker images and containers clearly to reflect their purpose and avoid conflicts.
- Use consistent tagging for Docker images, including version numbers and relevant metadata.
- Document any custom Docker build arguments or environment variables used in the project.
- Keep Docker-related scripts and configurations under version control to ensure reproducibility.
- Avoid using `latest` tag for base images; specify explicit versions to prevent unexpected changes.
- Use `.dockerignore` files to exclude unnecessary files from the build context and improve build performance.
- Ensure that sensitive information, such as credentials or API keys, is not included in the Docker build context.
- Regularly review and update Docker-related dependencies and configurations to maintain security and compatibility.
- Split command arguments across multiple lines in Dockerfiles for readability and maintainability.
- Use `COPY` and `ADD` instructions efficiently to minimize the number of layers and improve build performance.
- Leverage caching effectively by ordering instructions in Dockerfiles from least to most frequently changing.
- Regularly clean up unused Docker images, containers, and volumes to free up system resources and maintain a clean development environment.