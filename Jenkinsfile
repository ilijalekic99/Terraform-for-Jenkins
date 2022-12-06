pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
            checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/ilekicgrid/Terraform-for-jenkins.git']]])

          }
        }

        stage ("terraform init") {
            steps {
                sh ('terraform init -upgrade')
            }
        }

        stage ("terraform Action") {
        steps{
                withCredentials([string(credentialsId: 'access_key_id', variable: 'AWS_ACCESS_KEY_ID'),
                string(credentialsId: 'secret_access_key', variable: 'AWS_SECRET_ACCESS_KEY')]) {

                    echo "Terraform action is --> ${action}"
                    sh ('terraform ${action} --auto-approve -var-file="secrets.tfvars"')
                }
            }
        }
    }
}