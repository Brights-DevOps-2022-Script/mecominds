pipeline {
    agent any
    environment {
        ACRCreds = credentials('acr_creds')
       
    }
    
    stages {
        
        stage('ACR Login') {
            steps{
                sh 'docker login devops2022.azurecr.io -u $ACRCreds_USR -p $ACRCreds_PSW'
            }
        }

        stage('Image Building and push ACR') {                   
            steps {
                sh 'docker build -t devops2022.azurecr.io/nevermindset:$GIT_COMMIT .' 
                sh 'docker push devops2022.azurecr.io/nevermindset:$GIT_COMMIT'           
                sh 'docker rmi devops2022.azurecr.io/nevermindset:$GIT_COMMIT'           
            }

        }

        stage('Deploy') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: '2eb747c4-f19f-4601-ab83-359462e62482',  url: 'https://github.com/Brights-DevOps-2022-Script/neverMindset.git']]])
                withCredentials([usernamePassword(credentialsId: '2eb747c4-f19f-4601-ab83-359462e62482', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                sh 'sed -i "s|image:.*|image: devops2022.azurecr.io/nevermindset:$GIT_COMMIT|" k8s/deployment.yaml'
                sh "git add k8s/deployment.yaml"
                sh "git commit -m 'update deployment'"
                sh "git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/Brights-DevOps-2022-Script/neverMindset.git HEAD:main"
                }                            
            }

        }
    }

}    
    
