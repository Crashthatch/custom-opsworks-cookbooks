maintainer "Cambridge Data Solutions"
description "Deploy applications"
version "0.1"
recipe "raiteas::pythonserver", "Deploy the Python SVG server"
recipe "raiteas::addsupervisorjob", "Create a supervisor job"

depends "deploy"