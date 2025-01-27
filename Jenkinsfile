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
        LAST_COMMIT_FILE = '.last_commit'
    }

    stages {
        stage('Check for New Commits') {
            steps {
                script {
                    echo 'Checking for new commits...'
                    def currentCommit = ''
                    
                    // Clone repository silently to get the latest commit hash
                    checkout([$class: 'GitSCM',
                              branches: [[name: "${env.GIT_BRANCH}"]],
                              userRemoteConfigs: [[url: "${env.GIT_REPOSITORY_URL}", credentialsId: "${env.GIT_CREDENTIALS_ID}"]],
                              doGenerateSubmoduleConfigurations: false])

                    // Get the current commit hash
                    currentCommit = sh(script: "git rev-parse HEAD", returnStdout: true).trim()
                    echo "Current Commit: ${currentCommit}"
                    
                    // Check if there is a recorded last commit
                    if (fileExists(env.LAST_COMMIT_FILE)) {
                        def lastCommit = readFile(env.LAST_COMMIT_FILE).trim()
                        if (currentCommit == lastCommit) {
                            echo "No new commits detected. Skipping the pipeline."
                            currentBuild.result = 'NOT_BUILT'
                            error('No new commits')
                        }
                    }
                    
                    // Save the current commit hash for future reference
                    writeFile file: env.LAST_COMMIT_FILE, text: currentCommit
                }
            }
        }

        stage('Checkout Code') {
            steps {
                script {
                    retry(3) {
                        git url: "${env.GIT_REPOSITORY_URL}", branch: "${env.GIT_BRANCH}", credentialsId: "${env.GIT_CREDENTIALS_ID}"
                    }
                }
            }
        }

        stage('Check Python Version') {
            steps {
                script {
                    sh 'python3 --version'
                }
            }
        }

        stage('Install Python3-venv') {
            steps {
                script {
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
                    sh "${env.VENV_DIR}/bin/flake8 src/ --max-line-length=150"
                }
            }
        }
    }

    post {
        always {
            script {
                sh "rm -rf ${env.VENV_DIR}"
                sh 'docker compose -f docker-compose-blue.yml down --volumes --remove-orphans'
            }
        }

        success {
            script {
                echo 'Pipeline completed successfully!'
                sh 'docker compose -f docker-compose-green.yml down --remove-orphans'
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
