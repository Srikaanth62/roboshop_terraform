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
    steps {
      sh 'terraform init -backend-config=env-${env}/state.tfvars'
    }

   }
   stage ('terraform APPLY') {
   steps {
         sh 'terraform destroy -auto-approve -var-file=env-${env}/main.tfvars'
       }
   }

  }
  post {
    always {
     cleanWs()
    }
  }

}