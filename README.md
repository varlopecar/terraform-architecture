# CI/CD Infrastructure with Terraform

This Terraform project manages the infrastructure for a comprehensive CI/CD pipeline with multiple Docker architectures and cloud deployment options.

## 🏗️ Architecture Overview

### Docker Environment
- **MongoDB + Node.js API**: Blog API with Express.js and MongoDB
- **MySQL + Python + React + Adminer**: User registration system with FastAPI backend and React frontend
- **Mongo Express**: Web-based MongoDB admin interface
- **Adminer**: Web-based database management tool

### Cloud Environment (Scalingo)
- Scalable cloud deployment option
- GitHub integration for automated deployments

## 🚀 Quick Start

### Prerequisites
- [Terraform](https://www.terraform.io/downloads) >= 1.0
- [Docker](https://docs.docker.com/get-docker/) (for local development)
- [Docker Compose](https://docs.docker.com/compose/install/)

### 1. Configuration
```bash
# Copy the example configuration
cp terraform.tfvars.example terraform.tfvars

# Edit the configuration with your values
nano terraform.tfvars
```

### 2. Initialize Terraform
```bash
terraform init
```

### 3. Deploy Infrastructure
```bash
# For Docker environment (default)
terraform apply

# For Scalingo environment
terraform apply -var="environment=scalingo"
```

## 📁 Project Structure

```
terraform-architecture/
├── main.tf                 # Main Terraform configuration
├── variables.tf            # Variable definitions
├── outputs.tf              # Output values
├── terraform.tfvars.example # Example configuration
├── modules/
│   ├── docker/             # Docker environment module
│   │   ├── main.tf         # Docker containers and network
│   │   ├── variables.tf    # Module variables
│   │   ├── outputs.tf      # Module outputs
│   │   ├── mongo-init/     # MongoDB initialization scripts
│   │   └── sqlfiles/       # MySQL initialization scripts
│   └── scalingo/           # Scalingo environment module
│       ├── main.tf         # Scalingo app configuration
│       ├── variables.tf    # Module variables
│       └── outputs.tf      # Module outputs
└── .github/workflows/      # GitHub Actions workflows
    ├── terraform.yml       # Main CI/CD pipeline
    ├── on-dispatch.yml     # Manual trigger workflow
    └── test-dispatches.yml # Test workflow
```

## 🔧 Configuration Variables

### Environment Variables
- `environment`: Choose between "docker" or "scalingo"
- `docker_host`: Docker daemon socket path
- `github_token`: GitHub personal access token

### Database Configuration
- `mongo_image`: MongoDB Docker image
- `mongo_user`: MongoDB root username
- `mongo_password`: MongoDB root password
- `mongo_database`: MongoDB database name
- `mongo_atlas_uri`: MongoDB Atlas connection string (optional)

- `mysql_image`: MySQL Docker image
- `mysql_root_password`: MySQL root password
- `mysql_database`: MySQL database name
- `mysql_user`: MySQL user username
- `mysql_password`: MySQL user password

### Application Images
- `node_image`: Node.js API Docker image
- `python_image`: Python API Docker image
- `react_image`: React frontend Docker image
- `adminer_image`: Adminer Docker image

## 🌐 Services and Ports

| Service | Port | Description |
|---------|------|-------------|
| React Frontend | 3000 | User interface |
| Node.js API | 3001 | Blog API |
| Python API | 8000 | User registration API |
| MongoDB | 27017 | Database |
| MySQL | 3306 | Database |
| Adminer | 8081 | Database management |
| Mongo Express | 8082 | MongoDB management |

## 🔄 GitHub Actions Workflows

### Main CI/CD Pipeline (`terraform.yml`)
- Triggers on push to main branch
- Runs tests for all applications
- Deploys infrastructure with Terraform
- Updates GitHub repository with deployment status

### Manual Dispatch (`on-dispatch.yml`)
- Manual trigger for infrastructure updates
- Supports different environments (docker/scalingo)
- Includes validation and testing

### Test Workflows
- `test-dispatches.yml`: Tests dispatch workflows
- `test-express-only.yml`: Tests Express.js application specifically

## 🧪 Testing

The project includes comprehensive testing:

### Unit Tests
- **React App**: Vitest with coverage reporting
- **Node.js API**: Jest with coverage reporting

### Integration Tests
- **Node.js API**: Supertest for API endpoint testing
- **Database**: Connection and CRUD operation tests

### End-to-End Tests
- **Cypress**: Full user workflow testing
- **API Testing**: Complete API integration tests
- **Admin Panel**: Administrative functionality tests

## 🔐 Security

### Sensitive Data
- Database passwords are marked as sensitive
- GitHub tokens are encrypted
- Environment variables are properly managed

### Best Practices
- Use strong passwords in production
- Rotate tokens regularly
- Monitor access logs
- Use secrets management for production

## 🚀 Deployment

### Local Development
```bash
# Start all services
terraform apply

# View logs
docker-compose logs -f

# Stop services
terraform destroy
```

### Production (Scalingo)
```bash
# Deploy to Scalingo
terraform apply -var="environment=scalingo"

# Monitor deployment
terraform output scalingo_app_url
```

## 📊 Monitoring

### Health Checks
- Database connectivity monitoring
- API endpoint health checks
- Container status monitoring

### Logging
- Centralized logging for all services
- Error tracking and alerting
- Performance monitoring

## 🛠️ Troubleshooting

### Common Issues

1. **Docker not running**
   ```bash
   sudo systemctl start docker
   ```

2. **Port conflicts**
   - Check if ports are already in use
   - Modify port mappings in variables

3. **Database connection issues**
   - Verify database credentials
   - Check network connectivity
   - Review initialization scripts

4. **Terraform state issues**
   ```bash
   terraform init -reconfigure
   terraform plan
   ```

## 📝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License.

## 👥 Team Members

- **Student 1**: Docker Architecture & Terraform Configuration
- **Student 2**: Testing Framework & CI/CD Pipelines  
- **Student 3**: Documentation & Deployment Automation

## 🔗 Related Projects

- [Express MongoDB App](../express-mongodb-app/): Node.js API with MongoDB
- [React Form](../react-form/): React frontend with Python backend 