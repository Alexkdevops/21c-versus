pipeline {
  agent {
    kubernetes {
      defaultContainer 'jenkins-slave'
      yamlFile 'jenkins-slave.yaml'
    }
  }
  environment {
    // MYSQL_USER     = credentials('MYSQL_USER')
    // MYSQL_PASSWORD = credentials('MYSQL_PASSWORD')
    MYSQL_USER     = 'admin'
    MYSQL_PASSWORD = 'password'
  }
  stages {
    stage ('Enviromnet') {
      steps {
        script {
          if (env.GIT_BRANCH == 'dev') {
            stage ('Stage: dev') {
                env.STAGE = 'dev'
                sh 'echo ${STAGE}'
            }
          } else if (env.GIT_BRANCH == 'prod') {
            stage ('Stage: prod') {
                env.STAGE = 'prod'
                sh 'echo ${STAGE}'
            } 
          } else {
            stage ('Stage: main') {
                env.STAGE = 'main'
                sh 'echo ${STAGE}'
            }
          }            
        }
      }
    }
    // stage('Build Images') {
    //   steps {
    //     dir('frontend') {
    //       sh 'make build'
    //     }
    //     dir('backend') {
    //       sh 'make build'
    //     }
    //   }
    // }
    // stage('Push to Repo') {
    //         parallel {
    //             stage('Backend') {
    //                 steps {
    //                   dir('backend') {
    //                     sh 'make push'
    //                   }
    //                 }
    //             }
    //             stage('Frontend') {
    //                 steps {
    //                     dir('frontend') {
    //                       sh 'make push'
    //                     }
    //                 }
    //             }
    //         }
    //     }
    stage('Deployment') {
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
}
