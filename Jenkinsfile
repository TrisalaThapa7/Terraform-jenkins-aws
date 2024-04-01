pipeline {
    agent any

    parameters {
        booleanParam(
            name: 'autoApprove',
            defaultValue: false,
            description: 'Automatically run apply after generating plan?'
        )
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    dir("terraform") {
                        git url: 'https://github.com/TrisalaThapa7/Terraform-jenkins-aws.git'
                    }
                }
            }
        }

        stage('Plan') {
            steps {
                sh 'cd terraform && terraform init'
                sh 'cd terraform && terraform plan -out tfplan'
                sh 'cd terraform && terraform show -no-color tfplan > tfplan.txt'
            }
        }

        stage('Approval') {
            when {
                expression { params.autoApprove != true }
            }

            steps {
                script {
                    def plan = readFile 'terraform/tfplan.txt'
                    input message: "Do you want to apply the plan?",
                          parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                }
            }
        }

        stage('Apply') {
            when {
                expression { params.autoApprove == true }
            }

            steps {
                sh 'cd terraform && terraform apply -auto-approve tfplan'
            }
        }
    }
}
