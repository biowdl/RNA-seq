pipeline {
    agent {
        node {
            label 'local'
        }
    }
    parameters {
        string name: 'CROMWELL_JAR', defaultValue: '${DEFAULT}'
        string name: 'CROMWELL_CONFIG', defaultValue: '${DEFAULT}'
        string name: 'CROMWELL_BACKEND', defaultValue: '${DEFAULT}'
        string name: 'FIXTURE_DIR', defaultValue: '${DEFAULT}'
        string name: 'CONDA_PREFIX', defaultValue: '${DEFAULT}'
        string name: 'THREADS', defaultValue: '${DEFAULT}'
        string name: 'OUTPUT_DIR', defaultValue: '${DEFAULT}'
        string name: 'FUNCTIONAL_TESTS', defaultValue: '${DEFAULT}'
        string name: 'INTEGRATION_TESTS', defaultValue: '${DEFAULT}'
    }
    tools {
        jdk 'JDK 8u162'
    }
    stages {
        stage('Init') {
            steps {
                script {
                    params.each { key, value ->
                        if (value == '${DEFAULT}') {
                            configFileProvider([configFile(fileId: key, variable: 'FILE')]) {
                                script {
                                    env.('' + key)=sh(returnStdout: true, script: 'cat $FILE')
                                }
                            }
                        }
                        sh('echo ' + key + '=$' + key)
                    }
                }
                sh 'java -version'
                checkout scm
                sh 'git submodule update --init --recursive'
                script {
                    def sbtHome = tool 'sbt 1.0.4'
                    env.outputDir= "${env.OUTPUT_DIR}/${env.JOB_NAME}/${env.BUILD_NUMBER}"
                    env.sbt= "${sbtHome}/bin/sbt -Dbiowdl.functionalTests=${env.FUNCTIONAL_TESTS} -Dbiowdl.integrationTests=${env.INTEGRATION_TESTS} -Dbiowdl.outputDir=${outputDir} -Dcromwell.jar=${env.CROMWELL_JAR} -Dcromwell.config=${env.CROMWELL_CONFIG} -Dcromwell.extraOptions=-Dbackend.providers.${env.CROMWELL_BACKEND}.config.root=${outputDir}/cromwell-executions -Dbiowdl.fixtureDir=${env.FIXTURE_DIR} -Dbiowdl.threads=${env.THREADS} -no-colors -batch"
                }
                sh "rm -rf ${outputDir}"
                sh "mkdir -p ${outputDir}"

                sh "#!/bin/bash\n" +
                        "set -e -v -o pipefail\n" +
                        "${sbt} clean evicted scalafmt headerCreate | tee sbt.log"
                sh 'n=`grep -ce "\\* com.github.biopet" sbt.log || true`; if [ "$n" -ne \"0\" ]; then echo "ERROR: Found conflicting dependencies inside biopet"; exit 1; fi'
                sh "git diff --exit-code || (echo \"ERROR: Git changes detected, please regenerate the readme, create license headers and run scalafmt: sbt biopetGenerateReadme headerCreate scalafmt\" && exit 1)"
            }
        }

        stage('Submodules develop') {
            when {
                branch 'develop'
            }
            steps {
                sh 'git submodule foreach --recursive git checkout develop'
                sh 'git submodule foreach --recursive git pull'
            }
        }

        stage('Create conda environment') {
            steps {
                script {
                    env.envHash= sh(returnStdout: true, script: "sha256sum environment.yml | cut -f1 -d ' '")
                    env.condaEnv= "${env.CONDA_PREFIX}/envs/${envHash}"
                    env.activateEnv= "source ${env.CONDA_PREFIX}/bin/activate \$(readlink -f ${condaEnv})"
                    env.createEnv= "${env.CONDA_PREFIX}/bin/conda-env create -f environment.yml -p ${condaEnv}"
                }
                sh "#!/bin/bash\n" +
                    "set -e -v -o pipefail\n" +
                    "[[ -d ${env.condaEnv} ]] || ${createEnv}\n"
            }
        }

        stage('Build & Test') {
            steps {
                sh "#!/bin/bash\n" +
                        "set -e -v  -o pipefail\n" +
                        "${activateEnv}\n" +
                        "${sbt} test"
            }
        }
    }
    post {
        always {
            junit '**/test-output/junitreports/*.xml'
        }
        failure {
            slackSend(color: '#FF0000', message: "Failure: Job '${env.JOB_NAME} #${env.BUILD_NUMBER}' (<${env.BUILD_URL}|Open>)", channel: '#biopet-bot', teamDomain: 'lumc', tokenCredentialId: 'lumc')
        }
        unstable {
            slackSend(color: '#FFCC00', message: "Unstable: Job '${env.JOB_NAME} #${env.BUILD_NUMBER}' (<${env.BUILD_URL}|Open>)", channel: '#biopet-bot', teamDomain: 'lumc', tokenCredentialId: 'lumc')
        }
        aborted {
            slackSend(color: '#7f7f7f', message: "Aborted: Job '${env.JOB_NAME} #${env.BUILD_NUMBER}' (<${env.BUILD_URL}|Open>)", channel: '#biopet-bot', teamDomain: 'lumc', tokenCredentialId: 'lumc')
        }
        success {
            slackSend(color: '#00FF00', message: "Success: Job '${env.JOB_NAME} #${env.BUILD_NUMBER}' (<${env.BUILD_URL}|Open>)", channel: '#biopet-bot', teamDomain: 'lumc', tokenCredentialId: 'lumc')
        }
    }
}