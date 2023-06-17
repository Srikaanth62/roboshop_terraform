pipeline {
  agent {
    node {
      label 'workstation'
    }
  }
  parameters {
          choice(name: 'env', choices: ['dev', 'prod'], description: 'Pick environment')
      }
  stages {
   stage ('terraform INIT') {
     sh 'terraform init -backend-config=env-${env}/state.tfvars'
   }
   stage ('terraform APPLY')
     sh 'terraform apply -auto-approve -var-file=env-${env}/main.tfvars'
  }
  post {
    always {
     cleanWs()
    }
  }

}