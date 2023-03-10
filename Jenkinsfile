pipeline {
    agent any
    environment {
        ACRCreds = credentials('acr_creds')
    }
    stages {
        stage('BUILD') {                   
            steps {
                sh "docker login devops2022.azurecr.io -u $ACRCreds_USR -p $ACRCreds_PSW"
                sh "docker build -t devops2022.azurecr.io/mecominds:$GIT_COMMIT ./app"
                sh "docker push devops2022.azurecr.io/mecominds:$GIT_COMMIT"
                sh "docker rmi devops2022.azurecr.io/mecominds:$GIT_COMMIT"
            }
        }
        stage('TEST') {
            steps {
                 script {
                    def imageTag = "mecominds:$GIT_COMMIT"
                    def acrLoginServer = "devops2022.azurecr.io"
                    def imageExists = sh(script: "set +x curl -fL ${acrLoginServer}/v2/manifests/${imageTag}", returnStatus: true) == 0
                    if (!imageExists) {
                        error("The image ${imageTag} was not found in ${acrLoginServer} (ACR). Pipeline failed.")
                    }
                    sh "echo \"New image ${imageTag} successfully pushed. It exists now in the ACR ${acrLoginServer}\""
                }
            }
        }
        stage('DEPLOY') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '2eb747c4-f19f-4601-ab83-359462e62482',  url: 'https://github.com/Brights-DevOps-2022-Script/mecominds.git']]])
                withCredentials([usernamePassword(credentialsId: '2eb747c4-f19f-4601-ab83-359462e62482', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                sh "sed -i '19s|image:.*|image: devops2022.azurecr.io/mecominds:$GIT_COMMIT|' k8s/nginx.yml"
                sh "git add k8s/nginx.yml"
                sh "git commit -m 'update deployment file'"
                sh "git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/Brights-DevOps-2022-Script/mecominds.git HEAD:main"
                }                            
            }
        }
    }
}    
    
