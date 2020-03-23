pipeline {
  environment {
    registry = "silviaclaire/docker-test"
    registryCredential = 'dockerhub'
    dockerImage = ''
  }
  agent any
  tools {
    nodejs "node"
  }
  stages {
    stage('Cloning Git') {
      steps {
        git 'https://github.com/gustavoapolinario/node-todo-frontend'
      }
    }
    stage('Build') {
       steps {
         sh 'npm install'
       }
    }
    stage('Test') {
      steps {
        sh 'npm test'
      }
    }
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry
        }
      }
    }
    stage('Deploy Image') {
      steps{
         script {
            docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
    stage('Remove Unused docker image') {
      steps{
        sh "docker rmi $registry:latest"
      }
    }
  }
}