pipeline {
  agent {
    kubernetes {
      defaultContainer 'jenkins-slave'
      yamlFile 'jenkins.yaml'
    }
  }
  environment {
    MYSQL_USER     = credentials('MYSQL_USER')
    MYSQL_PASSWORD = credentials('MYSQL_PASSWORD')
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
    stage('Build Image') {
      steps {
        dir('frontend') {
          sh 'make build'
        }
        dir('backend') {
          sh 'make build'
        }
      }
    }
    // stage('Push to Repo') {
    //         parallel {
    //             stage('Push backend') {
    //                 steps {
    //                   dir('backend') {
    //                     sh 'make push'
    //                   }
    //                 }
    //             }
    //             stage('Push frontend') {
    //                 steps {
    //                     dir('frontend') {
    //                       sh 'make push'
    //                     }
    //                 }
    //             }
    //         }
    //     }
    // stage('Deployment') {
    //         parallel {
    //             stage('Deploy backend') {
    //                 steps {
    //                   dir('backend') {
    //                     sh 'make deploy'
    //                   }
    //                 }
    //             }
    //             stage('Deploy frontend') {
    //                 steps {
    //                     dir('frontend') {
    //                       sh 'make deploy'
    //                     }
    //                 }
    //             }
    //         }
    //     }
  }
}
