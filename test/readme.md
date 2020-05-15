# Hercules continuos integration user manual

## Getting started
These instructions give the most direct path to ediut, compile and execute the Continuos Integration for the Hércules Ontology. To build from source you will need about 2 GB of disk space for the source code and the ontology. Depending on your machine and your ethernet connection, a clean build can take a few minutes to several hours.

### System Requirements
Windows 10, macOS, Ubuntu Linux LTS, and the latest Ubuntu Linux release are currently supported as host development operating systems.

#### Java
You will need to install Java JDK, we recomend versión 11 but versions from 8 to 11 are supported. To do so you can use the following command on Unix based systems:
```bash
sudo apt-get update && apt-get upgrade;
sudo apt-get install oracle-java11-installer;
```

#### Maven
To install our dependecy and task manager on unix based systems you can execute the folowing command:
```bash
sudo apt update;
sudo apt install maven;
```

#### IDE
As IDEs for editing the code we recomend Eclipse IDE and IntelliJ IDE, both are perfectly valid for this project.

### Getting Sources for CI
First create a directoryu for all CI sources
```bash
mkdir hercules-ontology
cd hercules-ontology
```

**Via HTTPS** For those checking out sources as read-only, HTTPS works best:
```bash
git clone https://github.com/HerculesCRUE/ib-hercules-ontology.git
```

**Via SSH** For those who plan on regularly making direct commits, cloning over SSH may provide a better experience (which requires uploading SSH keys to GitHub):
```bash
git clone git@github.com:HerculesCRUE/ib-hercules-ontology.git
```

## Modifing the Tests Cases
Test cases are defined in the `test/manifest.json` file as follows:
```json
[
 {
    "test_name": "test that a project instance has all needed attributes",
    "ontology": "../../src/asio-core.ttl",
    "data": "../asio-individuals.ttl",
    "schema": "../project.s",
    "in_shape_map": "../project_in.m",
    "out_shape_map": "../project_out.m"
  },
  ...
]
```
Inside each test description we can see that each file needs a: `test_name`, `ontology`, `data`, `schema`, `in_shape_map`, `out_shape_map`. This fields need to meet the following specifications:

* `test_name`: is the name of the test, in case the test fail this name will be in the description of the failed test.
* `ontology`: is the path that points to the ontology to test.
* `data`: is the path that points to the data that will be used to populate the ontology during tests.
* `schema`: is the path to the shape expression to test the data and the ontology.
* `in_shape_map`: is the path to the input shape map, this shape map might contains the exact nodes to test against the schema or an sparql shape expression as a node selector.
* `out_shape_map`: is the path to the output expected shape expression. This is like the expected result in a test case.

You can add ad many test cases as you want.

## Modifing Sources
The sources of the CI are located at `test/test-launcher`. There you will find two folders, one called `main/java/es/weso` and another called `test/java/asio/ontology/test`. This second folder is the one that contains the code that is called from the corresponding GitHub Action when the CI is triggered. The first one contains all the code corresponding the manifest file parsing, the test generation and the validations with shaclex.

## Compiling and Executing Tests Cases
To execute the test cases you can do it as easy as:
```bash
cd test/test-launcher;
mvn test;
```
This will execute you tests and at the end you will get a result like this one:
```bash
Tests run: 3, Failures: 0, Errors: 0, Skipped: 0, Time elapsed: 4.811 sec - in asio.ontology.test.ValidationTest

Results :

Tests run: 3, Failures: 0, Errors: 0, Skipped: 0
```

## GitHub Integration
As told this system is intended to be executed automatically by GitHub each time there is a change in the ontology. For that we use GitHub actions. GitHub automatically creates an action for each defined workflow. And a wrkflow is defined by a YAML file in the `.github/workflows` folder. For example the current implementation of the CI is under the `.github/workflows/ci.yml` file.
```yml
# This workflow will build a Java project with Maven
# For more information see: https://help.github.com/actions/language-and-framework-guides/building-and-testing-java-with-maven

# The root name of the workflow. On checks it is printed as <root_name>/<job_name>.
name: Hercules CI

on: [push, pull_request]

jobs:

  # Test the ontology.
  test:

    # The job name.
    name: Test with Shape Expressions

    # This job will run on a linux virtual machine.
    runs-on: ubuntu-latest

    # The steps are, first, checkout, then set java version
    # to 11 and finally move to the tests forder and execute the tests.
    steps:
    - uses: actions/checkout@v2

    # Setting the java version.
    - name: Set up JDK 11
      uses: actions/setup-java@v1
      with:
        java-version: 11

    # Test with maven
    - name: Test with Maven
      run: |
        cd test/test-launcher/
        mvn test
```
You can modify this file as you want to change the conditions under which the CI is triggered by GitHub but to test the new configuration you will need to execute the workflow in GitHub by means of a `push` or a `pull_request`.
