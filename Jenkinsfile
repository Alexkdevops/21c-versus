pipeline {
  agent {
    kubernetes {
      idleMinutes 5
      defaultContainer 'jenkins-slave'
      yamlFile 'jenkins-pod.yaml'
    }
  }
  environment {
    MYSQL_USER     = credentials('MYSQL_USER')
    MYSQL_PASSWORD = credentials('MYSQL_PASSWORD')
  }
  stages {
    stage ('Initialize the enviromnet') {
      steps {
        script {
          if (env.GIT_BRANCH == 'staging') {
            stage ('Stage: staging') {
                env.STAGE = 'staging'
                sh 'echo ${STAGE}'
            }
          } else if (env.GIT_BRANCH == 'main') {
            stage ('Stage: prod') {
                env.STAGE = 'prod'
                sh 'echo ${STAGE}'
            } 
          } else {
            stage ('Stage: dev') {
                env.STAGE = 'dev'
                sh 'echo ${STAGE}'
            }
          }            
        }
      }
    }
    stage('Build containers') {
      steps {
        dir('frontend') {
          sh 'make build'
        }
        dir('backend') {
          sh 'make build'
        }
      }
    }
    stage('Run tests') {
            parallel {
                stage('Backend unit test') {
                    steps {
                      dir('backend') {
                        sh 'make test'
                      }
                    }
                }
                stage('Frontend unit tests') {
                    steps {
                        dir('frontend') {
                          sh 'yarn test --watchAll=false --coverage --silent'
                        }
                    }
                }
            }
        }
    stage('Push artifacts') {
            parallel {
                stage('Push backend') {
                    steps {
                      dir('backend') {
                        sh 'make push'
                      }
                    }
                }
                stage('Push frontend') {
                    steps {
                        dir('frontend') {
                          sh 'make push'
                        }
                    }
                }
            }
        }
    stage('Deploy to the EKS cluster') {
            parallel {
                stage('Deploy backend') {
                    steps {
                      dir('backend') {
                        sh 'make deploy'
                      }
                    }
                }
                stage('Deploy frontend') {
                    steps {
                        dir('frontend') {
                          sh 'make deploy'
                        }
                    }
                }
            }
        }
  }
  post {
      always {
         sh "docker system prune -a --volumes -f"
      }
   }
}
