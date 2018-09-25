pipeline {
    agent {
        node {
            label 'local'
        }
    }
    environment {
        DEFAULT_CROMWELL_JAR      = credentials('cromwell-jar')
        DEFAULT_CROMWELL_CONFIG   = credentials('cromwell-config')
        DEFAULT_CROMWELL_BACKEND  = credentials('cromwell-backend')
        DEFAULT_FIXTURE_DIR       = credentials('fixture-dir')
        DEFAULT_CONDA_PREFIX      = credentials('conda-prefix')
        DEFAULT_THREADS           = credentials('threads')
        DEFAULT_OUTPUT_DIR        = credentials('output-dir')
        DEFAULT_FUNCTIONAL_TESTS  = credentials('functional-tests')
        DEFAULT_INTEGRATION_TESTS = credentials('integration-tests')
    }
    parameters {
        string name: 'CROMWELL_JAR', defaultValue: '${DEFAULT_CROMWELL_JAR}'
        string name: 'CROMWELL_CONFIG', defaultValue: '${DEFAULT_CROMWELL_CONFIG}'
        string name: 'CROMWELL_BACKEND', defaultValue: '${DEFAULT_CROMWELL_BACKEND}'
        string name: 'FIXTURE_DIR', defaultValue: '${DEFAULT_FIXTURE_DIR}'
        string name: 'CONDA_PREFIX', defaultValue: '${DEFAULT_CONDA_PREFIX}'
        string name: 'THREADS', defaultValue: '${DEFAULT_THREADS}'
        string name: 'OUTPUT_DIR', defaultValue: '${DEFAULT_OUTPUT_DIR}'
        string name: 'FUNCTIONAL_TESTS', defaultValue: '${DEFAULT_FUNCTIONAL_TESTS}'
        string name: 'INTEGRATION_TESTS', defaultValue: '${DEFAULT_INTEGRATION_TESTS}'
    }
    tools {
        jdk 'JDK 8u162'
    }
    stages {
        stage('Init') {
            steps {
                sh 'java -version'
                checkout scm
                sh 'git submodule update --init --recursive'
                script {
                    def sbtHome = tool 'sbt 1.0.4'
                    env.outputDir= "${OUTPUT_DIR}/${JOB_NAME}/${BUILD_NUMBER}"
                    env.condaEnv= "${outputDir}/conda_env"
                    env.sbt= "${sbtHome}/bin/sbt -Dbiowdl.functionalTests=${FUNCTIONAL_TESTS} -Dbiowdl.integrationTests=${INTEGRATION_TESTS} -Dbiowdl.outputDir=${outputDir} -Dcromwell.jar=${CROMWELL_JAR} -Dcromwell.config=${CROMWELL_CONFIG} -Dcromwell.extraOptions=-Dbackend.providers.${CROMWELL_BACKEND}.config.root=${outputDir}/cromwell-executions -Dbiowdl.fixtureDir=${FIXTURE_DIR} -Dbiowdl.threads=${THREADS} -no-colors -batch"
                    env.activateEnv= "source ${CONDA_PREFIX}/activate \$(readlink -f ${condaEnv})"
                    env.createEnv= "${CONDA_PREFIX}/conda-env create -f environment.yml -p ${condaEnv}"
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
                sh "#!/bin/bash\n" +
                    "set -e -v -o pipefail\n" +
                    "${createEnv}\n"
            }
        }

        stage('Build & Test') {
            steps {
                sh "#!/bin/bash\n" +
                        "set -e -v\n" +
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