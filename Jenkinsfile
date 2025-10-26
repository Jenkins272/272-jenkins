// Declarative Jenkinsfile example for Jenkins integration with GitHub webhooks
// Place this file at the repository root (Jenkinsfile)
// Notes:
// - Multibranch Pipeline will automatically detect branches and use this Jenkinsfile.
// - For classic Pipeline jobs, configure the job's SCM to point to this repo and enable "GitHub hook trigger for GITScm polling" or use the Generic Webhook Trigger plugin.
// - Replace build/test commands with your project's build tool (maven/gradle/npm/etc.).

pipeline {
  agent any

  // githubPush() requires the GitHub plugin. If you prefer Generic Webhook Trigger plugin,
  // configure the job accordingly in Jenkins and remove the trigger here.
  triggers {
    githubPush()
  }

  environment {
    // Example of environment variables you may use
    REPO = 'Jenkins272/272-jenkins'
  }

  stages {
    stage('Checkout') {
      steps {
        echo "Checking out ${env.REPO} on branch ${env.BRANCH_NAME}"
        // Checkout the repository using pipeline SCM (works in Multibranch or Pipeline jobs with SCM configured)
        checkout scm
      }
    }

    stage('Build') {
      steps {
        echo 'Running build step'
        // Replace with your build command. Examples:
        // sh './gradlew assemble'
        // sh 'mvn -B package'
        // sh 'npm ci && npm run build'
        sh 'echo "(placeholder) build step - replace with your build tool"'
      }
    }

    stage('Test') {
      steps {
        echo 'Running tests'
        // Replace with your test command
        sh 'echo "(placeholder) test step - replace with your test command"'
      }

      post {
        always {
          echo 'Tests finished (placeholder).'
        }
      }
    }

    stage('Archive') {
      steps {
        echo 'Archiving artifacts (if any)'
        // Example (adjust patterns):
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
      // Optionally publish test results if your build produces JUnit XMLs
      // junit allowEmptyResults: true, testResults: '**/build/test-results/**/*.xml'
      echo 'Pipeline finished.'
    }
  }
}
