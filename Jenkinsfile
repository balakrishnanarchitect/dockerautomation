podTemplate(
    containers: [containerTemplate(name: 'jnlp', image: 'asia.gcr.io/indigo-plate-372313/image:latest')],
    volumes: [hostPathVolume(hostPath: '/var/run/docker.sock', mountPath: '/var/run/docker.sock'),
        persistentVolumeClaim(claimName: 'jenkinsagentpvc', mountPath: '/home/jenkins/agent', readOnly: false)
    ]) {
        node(POD_LABEL) {
            stage('Get a Maven project') {
                  container('jnlp') {
                    stage('Shell Execution') {
                        sh 'docker --version'
                        sh 'ls'
                        sh 'pwd'
                    }
                }
            } 
        }  
    } 
