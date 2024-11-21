pipeline {
    agent any

    environment {
        VENV_DIR = 'venv'
        REQUIREMENTS = 'requirements.txt'
        PYTHONPATH = "${PWD}/src"

        GIT_CREDENTIALS_ID = 'github-pat'
        GIT_REPOSITORY_URL = 'https://github.com/b0mbix/pis24z-flashcards-app.git'
        GIT_BRANCH = 'pipeline'    }

    stages {
        stage('Checkout Code') {
            steps {
                script {
                    // Clone the GitHub repository to the workspace
                    checkout scm
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
                    // Install dependencies from requirements.txt
                    sh "${VENV_DIR}/bin/pip install -r ${REQUIREMENTS}"
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    // Run tests with PYTHONPATH set
                    sh "PYTHONPATH=${PYTHONPATH} ${VENV_DIR}/bin/pytest tests/"
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
        
