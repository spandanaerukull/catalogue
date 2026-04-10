
pipeline{  
    agent  {
        label 'AGENT-1' // this specifies that the pipeline should run on any available agent that has the label 'AGENT-1', this allows for flexibility in choosing where the pipeline will execute, as it can run on any node that is part of the Jenkins environment, whether it's a master or a slave node, as long as it has the specified label.
    } 
    environment { // use this section to define environment variables that can be used throughout the pipeline, this is useful for storing values that are commonly used in multiple stages or steps, such as the name of the course or the version of the application being built.
        appVersion = '' //empty variable to store the application version, this variable will be populated in the Build stage by reading the version from the package.json file, and it can be used in subsequent stages for tasks such as tagging Docker images or deploying specific versions of the application.
        REGION = "us-east-1"
        ACC_ID = "315069654700"
        PROJECT = "roboshop"
        COMPONENT = "catalogue" 
         }

    options { // Define options for the pipeline, these options include setting a timeout for the pipeline execution to prevent it from running indefinitely and disabling concurrent builds to ensure that only one instance of the pipeline runs at a time, which can help avoid conflicts and resource contention.
        timeout(time: 30, unit: 'MINUTES')  // this option sets a timeout for the pipeline execution, if the pipeline takes longer than the specified time (30 minutes in this case), it will be automatically aborted to prevent it from running indefinitely and consuming resources unnecessarily.
        disableConcurrentBuilds() // this option disables concurrent builds, ensuring that only one instance of the pipeline runs at a time, which can help avoid conflicts and resource contention.
    }
    //   parameters { // Define parameters for user input when triggering the pipeline, these parameters allow users to provide input values that can be used in the pipeline execution, such as specifying a person's name, providing a biography, toggling a boolean value, making a choice from a list of options, or entering a password. These parameters can be accessed in the pipeline using the `params` object, for example `params.PERSON` to get the value of the PERSON parameter.
    //     string(name: 'PERSON', defaultValue: 'Mr Jenkins', description: 'Who should I say hello to?')
    //     text(name: 'BIOGRAPHY', defaultValue: '', description: 'Enter some information about the person')
    //     booleanParam(name: 'TOGGLE', defaultValue: true, description: 'Toggle this value')
    //     choice(name: 'CHOICE', choices: ['One', 'Two', 'Three'], description: 'Pick something')
    //     password(name: 'PASSWORD', defaultValue: 'SECRET', description: 'Enter a password') 
    // }

    // Build the application
    stages {
        stage('Read package.json') {
            steps {
                script {
                    def packageJson = readJSON file: 'package.json'
                    appVersion = packageJson.version
                    echo "Package version: ${appVersion}"
                }
            }
        }
        stage('Test') {
            steps {
                script{ // Define the steps to execute in the Test stage, in this case we are using a script block to execute some shell commands, we are printing a message to indicate that we are running tests, then we are sleeping for 5 seconds to simulate a test process, after that we are printing the environment variables using the env command and finally we are printing a personalized message using the input parameter PERSON.
                echo "Running tests..."
                  sh 'echo "Testing..."'
                }
                
            }
        }
        
    }
    post {  always { // this block will be executed regardless of the build result, it is useful for cleanup actions that should always be performed, such as deleting the workspace directory to ensure that any temporary files or artifacts created during the build process are removed and do not consume unnecessary disk space.
            echo "Cleaning up workspace..."
            deleteDir()  }
        success {
            echo "Build succeeded!"   }
        failure {
            echo "Build failed!"  }

    }
    
    

}


