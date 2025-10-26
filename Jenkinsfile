pipeline {
  agent any

  triggers {
    githubPush()
  }

  environment {
    REPO = 'Jenkins272/272-jenkins'
  }

  stages {
    stage('Checkout') {
      steps {
        echo "Checking out ${env.REPO} on branch ${env.BRANCH_NAME}"
        checkout scm
      }
    }

    stage('Build') {
      steps {
        echo 'Running build step'
        sh 'echo "Build step - replace with your build tool"'
      }
    }

    stage('Test') {
      steps {
        echo 'Running tests'
        sh 'echo "Test step - replace with your test command"'
      }

      post {
        always {
          echo 'Tests finished.'
        }
      }
    }

    stage('Archive') {
      steps {
        echo 'Archiving artifacts (if any)'
        archiveArtifacts artifacts: '**/build/libs/*.jar', allowEmptyArchive: true
      }
    }
  }

  post {
    success {
      echo "Build succeeded for ${env.BRANCH_NAME}"
    }
    failure {
      echo "Build failed for ${env.BRANCH_NAME}"
    }
    always {
      echo 'Pipeline finished.'
    }
  }
}
