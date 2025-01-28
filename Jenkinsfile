pipeline {
    agent any

    environment {
        VENV_DIR = '.venv'
        REQUIREMENTS = 'requirements.txt'
        PYTHONPATH = "${env.WORKSPACE}/src"
        GIT_CREDENTIALS_ID = 'github-pat'
        GIT_REPOSITORY_URL = 'https://github.com/b0mbix/pis24z-flashcards-app.git'
        GIT_BRANCH = 'brudnopis'
        EMAIL_RECIPIENT = 'jakub.baba.stud@pw.edu.pl'
    }

    stages {
        stage('Checkout Code') {
            steps {
                script {
                    retry(3) {
                        // Clone the GitHub repository to the workspace with credentials
                        git url: "${env.GIT_REPOSITORY_URL}", branch: "${env.GIT_BRANCH}", credentialsId: "${env.GIT_CREDENTIALS_ID}"
                    }
                }
            }
        }

        stage('Check Python Version') {
            steps {
                script {
                    // Ensure Python 3 is available
                    sh 'python3 --version'
                }
            }
        }

        stage('Install Python3-venv') {
            steps {
                script {
                    // Ensure python3-venv and python3-venv are installed
                    sh '''
                        if ! dpkg -l | grep -q python3-venv; then
                            apt-get update
                            apt-get install -y python3-venv
                        fi
                    '''
                }
            }
        }

        stage('Check docker') {
            steps {
                script {
                    sh 'setsid python3 /home/mbrzezi3/example.py > example.log &'
		    sh 'docker compose -f docker-compose-blue.yml down --volumes --remove-orphans'
                    sh 'docker compose -f docker-compose-blue.yml up --build -d'
                }
            }
        }

        stage('Setup Virtual Environment') {
            steps {
                script {
                    // Create virtual environment if it doesn't exist
                    if (!fileExists("${env.VENV_DIR}/bin/activate")) {
                        sh "python3 -m venv ${env.VENV_DIR}"
			sh ". ${env.VENV_DIR}/bin/activate"
                    }
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    // Install dependencies from requirements.txt
                    sh "${env.VENV_DIR}/bin/pip install -r ${env.REQUIREMENTS}"
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
		        sh 'docker compose -f docker-compose-blue.yml exec logic-blue pytest'
                sh 'docker compose -f docker-compose-blue.yml exec flutter-blue flutter test'

                }
            }
        }

        stage('Lint Code') {
            steps {
                script {
                    // Run flake8 for linting
                    sh "${env.VENV_DIR}/bin/flake8 src/ --max-line-length=150"
                }
            }
        }

    }

    post {
        always {
            script {
                // Cleaning up after pipeline execution
		        sh "rm -rf ${env.VENV_DIR}"

                sh 'docker compose -f docker-compose-blue.yml down --volumes --remove-orphans'
            }
        }

        success {
            script {
                echo 'Pipeline completed successfully!'
                sh 'docker compose -f docker-compose-green.yml down --volumes --remove-orphans'
                sh 'sleep 30'
                sh 'docker compose -f docker-compose-green.yml up --build -d'
            }
        }

        failure {
            script {
                mail to: "${env.EMAIL_RECIPIENT}",
                     subject: 'Pipeline Error',
                     body: """
                        The Jenkins pipeline *${env.JOB_NAME}* failed.
                        Please check the details:
                        Build URL: ${env.BUILD_URL}
                        Jenkins Job: ${env.JOB_NAME}
                        Build Number: ${env.BUILD_NUMBER}
                     """
            }
        }
    }
}
