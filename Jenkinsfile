def remote = [:]
    remote.name = 'Docker-server'
    remote.host = '52.87.189.140'
    remote.user = 'ubuntu'
    remote.password = 'password'
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
     stage('Remove Unused docker image') {
          steps{
              sh "docker rmi $imagename:$BUILD_NUMBER"
              sh "docker rmi $imagename:latest"
                        }
            }
      stage('Remote SSH') {
      sshCommand remote: remote, command: "ls -lrt"
      sshCommand remote: remote, command: "docker run -d -p 8080:8080 austinobioma/october-docker"
    
      }
  }
