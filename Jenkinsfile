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
          echo "Gradle version: $GRADLE_VERSION"
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
        print "Gradle version: $GRADLE_VERSION\n"
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
          additionalBuildArgs "--build-arg GRADLE_VERSION=$GRADLE_VERSION"
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
          additionalBuildArgs  '--build-arg GRADLE_VERSION=$GRADLE_VERSION'
        }
      }
      steps {
          sh 'gradle assembleRelease'
          sh 'ls -R app/build/outputs/apk'
          stash name: "apk", includes: 'app/build/outputs/apk/**', allowEmpty: true
          archiveArtifacts artifacts: 'app/build/outputs/apk/**', fingerprint: true
          sh 'find / -name "gradle-file-watching*.jar" 2>/dev/null'
      }
    }
  }
}
