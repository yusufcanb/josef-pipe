String pipelineScript = '''
pipeline {
    agent any
     stages {
        stage('Stage 0 - Check Environment') {
            steps {
                sh 'robot --outputdir output /opt/robots/watchdog.robot '
                sh 'mv output/log.html output/stage-0-logs.html'
                archiveArtifacts artifacts: 'output/stage-0-logs.html'
            }
        }
        stage('Stage 1 - Execute Robot') {
            steps {
                sh 'robot --outputdir output /opt/robots/health-check.robot'
                sh 'mv output/log.html output/stage-1-logs.html'
                archiveArtifacts artifacts: 'output/stage-1-logs.html'
            }
        }
    }
}
'''.stripIndent()

pipelineJob('Example Robot Pipeline') {
  definition {
    cps {
      script(pipelineScript)
      sandbox()
    }
  }
}

