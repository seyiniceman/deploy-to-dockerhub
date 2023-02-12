def remote = [:]
    remote.name = 'Docker-server'
    remote.host = '54.161.108.229'
    remote.user = 'ubuntu'
    remote.password = 'December2023#'
    remote.allowAnyHosts = true


pipeline {
  agent any
  environment {
       imagename = "austinobioma/october-docker"
       registryCredential = 'DockerHub'
       dockerImage = ''
           }
  stages {
    stage ('Build') {
      steps {
        sh 'mvn clean package'
      }
    }
    stage('Building Docker image') {
          steps{
                script {
                     dockerImage = docker.build imagename
                          }
                      }
                }
     stage('Deploy Image') {
           steps{
               script {
                    docker.withRegistry( '', registryCredential ) {
                    dockerImage.push("$BUILD_NUMBER")
                    dockerImage.push('latest')
                                              }
                                    }
                             }
                  }
     
      stage('Remote SSH') {
          steps{
      sshCommand remote: remote, command: "ls -lrt"
      sshCommand remote: remote, command: "docker run -d -p 80:8080 austinobioma/october-docker:7"
      }
      }
    
     stage('Remove Unused docker image') {
          steps{
              sh "docker rmi $imagename:$BUILD_NUMBER"
              sh "docker rmi $imagename:latest"
                        }
            }
      }
  }
