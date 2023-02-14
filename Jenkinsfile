podTemplate(
    containers: [containerTemplate(name: 'jnlp', image: 'asia.gcr.io/indigo-plate-372313/image:latest')],
    volumes: [hostPathVolume(hostPath: '/var/run/docker.sock', mountPath: '/var/run/docker.sock'),
        persistentVolumeClaim(claimName: 'jenkinsagentpvc', mountPath: '/home/jenkins/agent', readOnly: false)
    ]) {
        node(POD_LABEL) {
            stage('Get a Maven project') {
                  container('jnlp') {
                    stage('Checkout') {
                        git branch: 'main', credentialsId: 'balakrishnanarchitect', url: 'https://github.com/balakrishnanarchitect/dockerautomation.git'
                    }
                    stage('docker build') {
                        sh 'docker images'
                        sh 'docker build -t newimage:latest .'
                      }
                      stage ("Prompt for input") {
                                withCredentials([string(credentialsId: 'newtest', variable: 'p')]) {               
                                container('jnlp') {
                                    script {
                                    env.PASSWORD = input message: 'Please enter the password',
                                                    parameters: [password(defaultValue: '',
                                                                description: '',
                                                                name: 'Password')]
                                    }                     
                                if (env.PASSWORD != p) 
                                {
                                echo "password is incorrect"
                                error("Password is incorrect")
                                    } 
                                else {      
                                    stage('image push') {
                                            withCredentials([file(credentialsId: 'secret', variable: 'key')]) {
                                                sh 'pwd'
                                                sh 'gcloud auth activate-service-account --key-file=${key} --project=indigo-plate-372313'
                                                sh 'gcloud auth configure-docker'
                                                sh 'docker tag newimage:latest asia.gcr.io/indigo-plate-372313/image:latest'
                                                sh 'docker push asia.gcr.io/indigo-plate-372313/image:latest'
                                            }
                                        }    
                                    }        
                                    stage('Docker image cleanup') {
                                        sh 'docker images'
                                        sh '''docker rmi $(docker images 'newimage' -q) --force'''
                                            }
                                    }
                           }
                      }                
                  }
            }
        }
    }


