pipeline {

  agent any

  options {
    timestamps()
  }

  stages {
    stage('Test authors') {
      agent {
        dockerfile {
          dir 'cicd/python'
          args '--network bridge'
          reuseNode true
        }
      }
      steps {
        sh 'git shortlog -s -n --all  --summary --numbered --email  >> /tmp/git_authors.txt'
        sh 'python3 cicd/test_authors.py'
      }
    }

    stage('Local unit test') {
      agent {
        dockerfile {
          dir 'cicd/androidsdk'
          reuseNode true
          args "-v \"$HOME/.gradle\":/root/.gradle"
        }
      }
      steps {
          sh './gradlew test'
      }
    }

    stage('Integration test') {
      environment {
        ANDROID_ADB_SERVER_ADDRESS = "host.docker.internal"
      }
      agent {
        dockerfile {
          dir 'cicd/androidsdk'
          reuseNode true
        }
      }
      steps {
          sh 'adb devices'
          sh './gradlew connectedAndroidTest'
      }
    }

    stage('Build') {
      agent {
        dockerfile {
          dir 'cicd/androidsdk'
          reuseNode true
          args "-v \"$HOME/.gradle\":/root/.gradle"
        }
      }
      steps {
          sh './gradlew assembleRelease'
          sh 'ls -R app/build/outputs/apk'
          stash name: "apk", includes: 'app/build/outputs/apk/**', allowEmpty: true
          archiveArtifacts artifacts: 'app/build/outputs/apk/**', fingerprint: true
      }
    }
  }
}
