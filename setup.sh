#!/bin/bash

# CI/CD Infrastructure Setup Script
# This script helps you quickly set up and deploy the infrastructure

set -e

echo "🚀 CI/CD Infrastructure Setup"
echo "=============================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check prerequisites
check_prerequisites() {
    print_status "Checking prerequisites..."
    
    # Check if Terraform is installed
    if ! command -v terraform &> /dev/null; then
        print_error "Terraform is not installed. Please install Terraform first."
        exit 1
    fi
    
    # Check if Docker is installed
    if ! command -v docker &> /dev/null; then
        print_error "Docker is not installed. Please install Docker first."
        exit 1
    fi
    
    # Check if Docker is running
    if ! docker info &> /dev/null; then
        print_error "Docker is not running. Please start Docker first."
        exit 1
    fi
    
    print_success "All prerequisites are met!"
}

# Setup configuration
setup_configuration() {
    print_status "Setting up configuration..."
    
    # Check if terraform.tfvars already exists
    if [ -f "terraform.tfvars" ]; then
        print_warning "terraform.tfvars already exists. Do you want to overwrite it? (y/N)"
        read -r response
        if [[ ! "$response" =~ ^[Yy]$ ]]; then
            print_status "Keeping existing terraform.tfvars"
            return
        fi
    fi
    
    # Copy example configuration
    if [ -f "terraform.tfvars.example" ]; then
        cp terraform.tfvars.example terraform.tfvars
        print_success "Configuration file created from example"
    else
        print_error "terraform.tfvars.example not found"
        exit 1
    fi
    
    print_warning "Please edit terraform.tfvars with your specific values before proceeding"
    print_status "You can use: nano terraform.tfvars"
}

# Initialize Terraform
initialize_terraform() {
    print_status "Initializing Terraform..."
    
    if terraform init; then
        print_success "Terraform initialized successfully"
    else
        print_error "Failed to initialize Terraform"
        exit 1
    fi
}

# Validate configuration
validate_configuration() {
    print_status "Validating Terraform configuration..."
    
    if terraform validate; then
        print_success "Configuration is valid"
    else
        print_error "Configuration validation failed"
        exit 1
    fi
}

# Plan deployment
plan_deployment() {
    print_status "Planning deployment..."
    
    if terraform plan; then
        print_success "Deployment plan created successfully"
    else
        print_error "Failed to create deployment plan"
        exit 1
    fi
}

# Deploy infrastructure
deploy_infrastructure() {
    print_status "Deploying infrastructure..."
    
    print_warning "This will create Docker containers and networks. Continue? (y/N)"
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        print_status "Deployment cancelled"
        return
    fi
    
    if terraform apply -auto-approve; then
        print_success "Infrastructure deployed successfully!"
    else
        print_error "Failed to deploy infrastructure"
        exit 1
    fi
}

# Show status
show_status() {
    print_status "Checking infrastructure status..."
    
    echo ""
    echo "📊 Infrastructure Status:"
    echo "========================="
    
    # Show Terraform outputs
    terraform output
    
    echo ""
    echo "🐳 Docker Containers:"
    echo "===================="
    docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
    
    echo ""
    echo "🌐 Services:"
    echo "==========="
    echo "React Frontend: http://localhost:3000"
    echo "Node.js API:    http://localhost:3001"
    echo "Python API:     http://localhost:8000"
    echo "Adminer:        http://localhost:8081"
    echo "Mongo Express:  http://localhost:8082"
}

# Main menu
show_menu() {
    echo ""
    echo "🔧 Setup Options:"
    echo "================="
    echo "1) Full setup (check prerequisites, configure, deploy)"
    echo "2) Check prerequisites only"
    echo "3) Setup configuration only"
    echo "4) Initialize Terraform only"
    echo "5) Validate configuration only"
    echo "6) Plan deployment only"
    echo "7) Deploy infrastructure only"
    echo "8) Show status"
    echo "9) Destroy infrastructure"
    echo "0) Exit"
    echo ""
    read -p "Choose an option (0-9): " choice
}

# Destroy infrastructure
destroy_infrastructure() {
    print_status "Destroying infrastructure..."
    
    print_warning "This will destroy all Docker containers and networks. Continue? (y/N)"
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        print_status "Destruction cancelled"
        return
    fi
    
    if terraform destroy -auto-approve; then
        print_success "Infrastructure destroyed successfully!"
    else
        print_error "Failed to destroy infrastructure"
        exit 1
    fi
}

# Main execution
main() {
    case $1 in
        "full")
            check_prerequisites
            setup_configuration
            initialize_terraform
            validate_configuration
            plan_deployment
            deploy_infrastructure
            show_status
            ;;
        "check")
            check_prerequisites
            ;;
        "config")
            setup_configuration
            ;;
        "init")
            initialize_terraform
            ;;
        "validate")
            validate_configuration
            ;;
        "plan")
            plan_deployment
            ;;
        "deploy")
            deploy_infrastructure
            ;;
        "status")
            show_status
            ;;
        "destroy")
            destroy_infrastructure
            ;;
        *)
            # Interactive mode
            while true; do
                show_menu
                case $choice in
                    1)
                        check_prerequisites
                        setup_configuration
                        initialize_terraform
                        validate_configuration
                        plan_deployment
                        deploy_infrastructure
                        show_status
                        ;;
                    2)
                        check_prerequisites
                        ;;
                    3)
                        setup_configuration
                        ;;
                    4)
                        initialize_terraform
                        ;;
                    5)
                        validate_configuration
                        ;;
                    6)
                        plan_deployment
                        ;;
                    7)
                        deploy_infrastructure
                        ;;
                    8)
                        show_status
                        ;;
                    9)
                        destroy_infrastructure
                        ;;
                    0)
                        print_status "Goodbye!"
                        exit 0
                        ;;
                    *)
                        print_error "Invalid option"
                        ;;
                esac
            done
            ;;
    esac
}

# Run main function with arguments
main "$@" 