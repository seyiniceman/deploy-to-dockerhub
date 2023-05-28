def remote = [:]
    remote.name = 'Docker-server'
    remote.host = '13.59.216.85'
    remote.user = 'ubuntu'
    remote.password = 'Februaryclass2023#'
    remote.allowAnyHosts = true


pipeline {
  agent any

  environment {
       imagename = "austinobioma/feb-class"
       registryCredential = 'DockerHub'
       dockerImage = ''
           }

    stages {

      stage (' MaVEN Build') {
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

      stage('Push Image to dockerHub') {
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
          sshCommand remote: remote, command: "docker run --name devops-app -d -p 80:8080 austinobioma/feb-class:2"
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
