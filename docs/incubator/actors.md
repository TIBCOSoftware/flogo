# Overview
This document explains all the different actors that will interact with the flogo oss ecosystem, its responsibilities and characteristics.

## App Developer 
This actor does not necessary have golang knowledge, and will rely on flogo gui (cli, web) to create and build  the application

### Responsibilities
- Creation of app structure using flogo-cli<br>
- Creation of app structure using flogo-web<br>
- Build of app using flogo-cli<br>
- Build of app using flogo-web <br>
- Run app

## Trigger/Action contributor
This actor have golang knowledge, so will be aware of  how golang structures the projects, trigger, action and  activities will be structured according to golang best practices.

### Responsibilities
- Generation of trigger initial structure using flogo-cli<br>
- Development of trigger go code logic<br>
- Generation of action initial structure using flogo-cli<br>
- Development of action go code logic<br>
- Generation of activity initial structure using flogo-cli<br>
- Development of activity go code logic<br>

## Core developer
This actor have golang knowledge and also has deep knowledge  on flogo internals.

### Responsibilities
- Development of flogo-cli<br>
- Development of flogo-web<br>
- Development of flogo-lib<br>
- Development of flogo-contrib<br>
- Development of flogo-services<br>

##Flow developer
This actor does only need flogo-web knowledge >and will use the  browser to design flows adding activities/error flows, etc....                                       

### Responsibilities
- Design of flows using flogo-web<br>