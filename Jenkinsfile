pipeline {

  agent any

  options {
    timestamps()
  }

  stages {
    stage('Read gradle version') {
      steps {
        script {
          def props = readProperties file: "gradle/wrapper/gradle-wrapper.properties"
          echo "Gradle version: ${props.distributionUrl}"
        }
      }
    }

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
          args '--network bridge'
          reuseNode true
          additionalBuildArgs  '--build-arg GRADLE_VERSION=7.5.1'
        }
      }
      steps {
          sh 'gradle test'
      }
    }
    stage('Build') {
      agent {
        dockerfile {
          dir 'cicd/androidsdk'
          args '--network bridge'
          reuseNode true
        }
      }
      steps {
          sh 'gradle assembleRelease'
          sh 'ls -R app/build/outputs/apk'
          stash name: "apk", includes: 'app/build/outputs/apk/**', allowEmpty: true
          archiveArtifacts artifacts: 'app/build/outputs/apk/**', fingerprint: true
          sh 'find / -name 'gradle-file-watching*.jar' 2>/dev/null'
      }
    }
  }
}
