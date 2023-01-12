pipeline {
  agent any
  stages {
    stage ("Checkout code") {
      steps {
        checkout scm
      }
    }
    stage ("Build") {
      agent {
        docker {
            image 'maven:3-openjdk-11'
        }
      }
      steps {
        sh '''
         mvn clean install
        '''
      }
    }
    stage ("SemGrep") {
      // agent {
      //   docker {
      //       image 'returntocorp/semgrep'
      //   }
      // }
      steps {
        script {
          docker.image('returntocorp/semgrep').inside("--entrypoint=''") {
            sh semgrep scan --config=auto --sarif -o semgrep-report.sarif
          }
        }
      }
    }
    stage('Checkov') {
             steps {
                 script {
                     docker.image('bridgecrew/checkov:latest').inside("--entrypoint=''") {
                         try {
                             sh 'checkov -d . --use-enforcement-rules -o cli -o junitxml --output-file-path console,results.xml --branch master'
                             junit skipPublishingChecks: true, testResults: 'results.xml'
                         } catch (err) {
                             junit skipPublishingChecks: true, testResults: 'results.xml'
                             throw err
                         }
                     }
                 }
             }
         }
  }
}
// pipeline{
//     agent {
//         label 'MVN3'
//     }
//     stages{
//         stage('clone'){
//             steps{
//                 git url: 'https://github.com/ACN-APPSAS/shopizer.git',
//                     branch: 'master'
//             }
//         }
//         stage ('build') {
//             steps {
//                sh 'mvn clean package'
//            }
//         }
//         stage('Build the Code') {
//             steps {
//                 withSonarQubeEnv('sonarcloud') {
//                     sh script: 'mvn clean package sonar:sonar'
//                 }
//             }
//         stage('archiving-artifacts'){
//             steps{
//                 archiveArtifacts artifacts: '**/target/*.jar', followSymlinks: false
//             }
//         }
//         stage('junit_reports'){
//             steps{
//                 junit '**/surefire-reports/*.xml'
//             }
//         }
//     }    

// pipeline {
//     agent {label 'OPENJDK-11-JDK'}
//     triggers {
//         pollSCM('0 17 * * *')
//     }
//     stages {
//         stage('vcs') {
//             steps {
//                 git branch: 'release', url: 'https://github.com/ACN-APPSAS/shopizer.git'         
//             }
//         }
//         stage('merge') {
//             steps {
//                 sh 'git checkout devops'
//                 sh 'git merge release --no-ff'
//             }
//         }
//         stage('build') {
//             steps {
//                 sh 'mvn clean install'
//             }
//         }
//     }
// }