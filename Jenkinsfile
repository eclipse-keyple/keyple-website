#!groovy
pipeline {
    agent {
        kubernetes {
            label 'keyple-website'
            yaml """
apiVersion: v1
kind: Pod
spec:
  containers:
  - name: node-instance
    image: node:lts
    imagePullPolicy: Always
    tty: true
    resources:
      requests:
        cpu: 100m
        memory: 100Mi
      limits:
        cpu: 1
        memory: 1Gi
    volumeMounts:
    - name: volume-known-hosts
      mountPath: /home/jenkins/.ssh
  volumes:
  - name: volume-known-hosts
    configMap:
      name: known-hosts
"""
        }
    }
    environment {
        HOME = '.'
    }
    stages {
        stage('Keyple Website: Build') {
            steps{
                container('node-instance') {
                    sh 'npm install'
                    sh './node_modules/.bin/hugo --minify'
                }
            }
        }
    }
}
