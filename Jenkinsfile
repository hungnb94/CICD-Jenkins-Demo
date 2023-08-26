pipeline {

  agent any

  options {
    timestamps()
  }

  stages {
    stage('Read gradle version') {
      steps {
        script {
          def gradleProps = readProperties file: "gradle/wrapper/gradle-wrapper.properties"
          def url="${gradleProps.distributionUrl}"
          GRADLE_VERSION = url.substring(url.indexOf("-") + 1, url.lastIndexOf("-"))
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
          reuseNode true
          additionalBuildArgs "--build-arg GRADLE_VERSION=$GRADLE_VERSION"
          args "-v \"$HOME/.gradle\":/root/.gradle"
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
          reuseNode true
          additionalBuildArgs "--build-arg GRADLE_VERSION=$GRADLE_VERSION"
          args "-v \"$HOME/.gradle\":/root/.gradle"
        }
      }
      steps {
          sh 'gradle assembleRelease'
          sh 'ls -R app/build/outputs/apk'
          stash name: "apk", includes: 'app/build/outputs/apk/**', allowEmpty: true
          archiveArtifacts artifacts: 'app/build/outputs/apk/**', fingerprint: true
      }
    }
  }
}
