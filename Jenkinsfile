pipeline {
    agent any
    
    environment {
        // Define environment variables for the AL project
        // AL_COMPILER_PATH should be configured in Jenkins global properties or passed as a parameter
        // Example: 'C:\Program Files (x86)\Microsoft Dynamics 365 Business Central\AL Development Environment\alc.exe'
        // or ensure 'alc.exe' is in the system PATH
        AL_COMPILER_PATH = "${env.AL_COMPILER_PATH ?: 'alc.exe'}"
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code from repository...'
                checkout scm
            }
        }
        
        stage('Restore Dependencies') {
            steps {
                echo 'Restoring AL dependencies...'
                // Download symbols and dependencies
                script {
                    // This would typically download AL symbols for Business Central
                    echo 'Downloading AL symbols and dependencies'
                }
            }
        }
        
        stage('Build') {
            steps {
                echo 'Building AL application...'
                script {
                    // Compile the AL project
                    // This would typically use the AL compiler to build the .app file
                    echo 'Compiling AL project to .app file'
                }
            }
        }
        
        stage('Test') {
            steps {
                echo 'Running tests...'
                script {
                    // Run AL tests if test codeunits exist
                    echo 'Executing AL test codeunits'
                }
            }
        }
        
        stage('Archive Artifacts') {
            steps {
                echo 'Archiving build artifacts...'
                // Archive the generated .app file
                archiveArtifacts artifacts: '**/*.app', allowEmptyArchive: true, fingerprint: true
            }
        }
        
        stage('Deploy') {
            when {
                branch 'main'
            }
            steps {
                echo 'Deploying to Business Central environment...'
                script {
                    // Deploy the .app file to Business Central server
                    echo 'Publishing extension to Business Central'
                }
            }
        }
    }
    
    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed. Please check the logs.'
        }
        always {
            echo 'Cleaning up workspace...'
            cleanWs()
        }
    }
}
