pipeline {
    agent any

    environment {
        VENV_DIR = '.venv'
        REQUIREMENTS = 'requirements.txt'
        PYTHONPATH = "${env.WORKSPACE}/src"
        GIT_CREDENTIALS_ID = 'github-pat'
        GIT_REPOSITORY_URL = 'https://github.com/b0mbix/pis24z-flashcards-app.git'
        GIT_BRANCH = 'PIS-7-skonfigurowanie-nexusa'
        EMAIL_RECIPIENT = 'jakub.baba.stud@pw.edu.pl'
    }

    stages {
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
                    // Ensure python3-venv is installed (for Ubuntu/Debian systems)
                    sh '''
                    if ! dpkg -l | grep -q python3-venv; then
                        sudo apt-get update
                        sudo apt-get install -y python3-venv
                    fi
                    '''
                }
            }
        }

        stage('Check docker') {
            steps {
                script {
                    sh 'docker --version'
                    sh 'docker compose down'
                    try {
                        sh 'docker compose up --build -d'
                    } catch (Exception e) {
                        echo "Error occurred during docker compose up: ${e.getMessage()}"
                    } finally {
                        // Clean up containers in any case
                        sh 'docker compose down'
                    }
                }
            }
        }

        stage('Checkout Code') {
            steps {
                script {
                    retry(3) {
                        // Clone the GitHub repository to the workspace with credentials
                        git url: "${GIT_REPOSITORY_URL}", branch: "${GIT_BRANCH}", credentialsId: "${GIT_CREDENTIALS_ID}"
                    }
                }
            }
        }

        stage('Setup Virtual Environment') {
            steps {
                script {
                    // Create virtual environment if it doesn't exist
                    if (!fileExists("${VENV_DIR}/bin/activate")) {
                        sh "python3 -m venv ${VENV_DIR}"
                    }
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    // Install dependencies from requirements.txt with caching
                    sh "${VENV_DIR}/bin/pip install -r ${REQUIREMENTS}"

                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    // Run tests with PYTHONPATH set correctly
                    sh "PYTHONPATH=${env.WORKSPACE}/src ${VENV_DIR}/bin/pytest tests/"
                }
            }
        }

        stage('Run Application') {
            steps {
                script {
                    // Run the application
                    sh "${VENV_DIR}/bin/python src/main.py"
                }
            }
        }

        stage('Lint Code') {
            steps {
                script {
                    // Run flake8 for linting
                    sh "${VENV_DIR}/bin/flake8 src/ tests/"
                }
            }
        }

        stage('Clean Up') {
            steps {
                script {
                    // Clean the virtual environment
                    sh "rm -rf ${VENV_DIR}"
                }
            }
        }
    }
    post {
        always {
            script {
                // Always perform clean-up or logging actions
                echo 'Cleaning up after pipeline execution'
            }
        }

        success {
            script {
                // You can add a success notification here if needed
                echo 'Pipeline completed successfully!'
            }
        }

        failure {
            script {
                // Send email in case of failure

                mail to: "${EMAIL_RECIPIENT}",
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