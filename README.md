# Reproducing Docker Log inconsistency

## Steps

    ./test

### Test Script

```sh
docker build -t="thlorenz/docker-logs-issue-repro" .
JOB=$(docker run -d thlorenz/docker-logs-issue-repro)

# The below should print out the entire license file, but prints only about the top 20% or even less (it varies)

echo '\n\033[00;32m +++ FIRST LOG +++\033[00m\n'
docker logs $JOB

echo '\n\033[00;32m +++ SECOND LOG +++\033[00m\n'
docker logs $JOB

echo '\n\033[00;32m +++ THIRD LOG +++\033[00m\n'
docker logs $JOB
```


### Dockerfile

```
from ubuntu:12.10

entrypoint [ "cat" ]
cmd [ "docker-license.txt" ]

add . /src
workdir /src
```

**NOTE**: `docker-license.txt` contains the complete docker license


## Results

Not consistent, here is one:

```
➝  ./test
Uploading context 15.87 kB
Uploading context
Step 0 : from ubuntu:12.10
 ---> 5ac751e8d623
Step 1 : entrypoint [ "cat" ]
 ---> Using cache
 ---> cf57ff05225f
Step 2 : cmd [ "docker-license.txt" ]
 ---> Using cache
 ---> 02c5775d6df0
Step 3 : add . /src
 ---> Using cache
 ---> 04fc9b087437
Step 4 : workdir /src
 ---> Using cache
 ---> 40d61c29802b
Successfully built 40d61c29802b

 +++ FIRST LOG +++


                                 Apache License
                           Version 2.0, January 2004
                        http://www.apache.org/licenses/

   TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION

   1. Definitions.

      "License" shall mean the terms and conditions for use, reproduction,
      and distribution as defined by Sections 1 through 9 of this document.

      "Licensor" shall mean the copyright owner or entity authorized by
      the copyright owner that is granting the License.

      "Legal Entity" shall mean the union of the acting entity and all
      other entities that control, are controlled by, or are under common
      control with that entity. For the purposes of this definition,
      "control" means (i) the power, direct or indirect, to cause the
      direction or management of such entity, whether by contract or
      otherwise, or (ii) ownership of fifty percent (50%) or more of the
      outstanding shares, or (iii) beneficial ownership of such entity.

      "You" (or "Your") shall mean an individual or Legal Entity
      exercising permissions granted by this License.

      "Source" form shall mean the preferred form for making modifications,
      including but not limited to software source code, documentation
      source, and configuration files.

      "Object" form shall mean any form resulting from mechanical
      transformation or translation of a Source form, including but

 +++ SECOND LOG +++


                                 Apache License
                           Version 2.0, January 2004
                        http://www.apache.org/licenses/


 +++ THIRD LOG +++


                                 Apache License
                           Version 2.0, January 2004
                        http://www.apache.org/licenses/

   TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION

   1. Definitions.

      "License" shall mean the terms and conditions for use, reproduction,
      and distribution as defined by Sections 1 through 9 of this document.

      "Licensor" shall mean the copyright owner or entity authorized by
      the copyright owner that is granting the License.

      "Legal Entity" shall mean the union of the acting entity and all
      other entities that control, are controlled by, or are under common
      control with that entity. For the purposes of this definition,
      "control" means (i) the power, direct or indirect, to cause the
      direction or management of such entity, whether by contract or
      otherwise, or (ii) ownership of fifty percent (50%) or more of the
      outstanding shares, or (iii) beneficial ownership of such entity.

      "You" (or "Your") shall mean an individual or Legal Entity
      exercising permissions granted by this License.

      "Source" form shall mean the preferred form for making modifications,
      including but not limited to software source code, documentation
      source, and configuration files.

      "Object" form shall mean any form resulting from mechanical
      transformation or translation of a Source form, including but
```
