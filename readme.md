# Sponsored by
https://creditorwatch.com.au

# Orchestrator for Static Code Analysis (SAST + SCA + CQA)
This repository would allow us to use an Orchestrator (GrumPHP) in the form of a docker image
that will be able to run different static code analyses to safeguard our security and enhance our code quality.

# Install in a new repository for local run
The repository contains already two version on GrumPHP; One for PHPv7 and another for PHPv8. As soon as you push 
the docker image into your registry, you will be able to use it in your CI/CD pipeline and local development just adding
the definition of the docker image in your docker-compose.yml.

```
test-tool:
  image: <<your-repo>>/internal-sast-grumphpv7
  working_dir: /code
  environment:
    GRUMPHP_BIN_DIR: /opt/vendor/bin
  volumes:
    - .:/code:cached
```

```
test-tool:
  image: <<your-repo>>/internal-sast-grumphpv8
  working_dir: /code
  environment:
    GRUMPHP_BIN_DIR: /opt/vendor/bin
  volumes:
    - .:/code:cached
```


# Limitation
- The project doesn't have a pipeline, therefore you need to build and push from your local
- You need to be logged in dockerhub to be able to push the image on the repository
- We must have file duplication as configuration can diverge from php7 vs php8

### Why do we have two different versions?
Unfortunately, php7 and php8 have different pre-requisite; It's not only the language that will change, but even the composer.json and the configuration related to
grumPHP (as the v8 supports a more recent version with lots of improvements)

### Build && Push
As soon as you've finished with your changes, you can build and push using the ```push.sh```. In the future, we need to create a better pipeline.

### Global Configuration
To add more global configurations, you need to specify a task on the /config/grumphp/*.yml folder.

All global tasks must respect this notation where the service name:


And the metadata definition should have the


(Example with phpstan):

``<<task_name>>_cicd`` #Generic Convention
```
grumphp:
  tasks:
    phpstan_cicd:
```
``task: <<task_name>>`` #Generic Convention
```      
metadata:
  blocking: true
  task: phpstan
````

#### grumphp.yml
If your team wants to customise the grumPHP tasks, they need to copy/paste this file on their repository root directory.


### Specific / Team Configuration
If you want to extend what grumPHP does, copy/paste the ``grumphp. yml``into the root of your project.

If you want to add more task or run the same task with a different configuration, please add the configuration in
``./config/grumphp/*.yml``

# Resources
https://github.com/phpro/grumphp
