Apache Maven archetype for your Gateway projects
================================================

Vortex Gateway provide an archetype to quickly generate a Maven project
configured with Gateway usage and with a Java class to be completed with
your Camel routes definition.

This archetype is automatically added to your local archetype catalog
during Vortex Gateway installation.

To create your project, run the following command and follow the
instructions below:

``` {.sourceCode .bash}
mvn archetype:generate -DarchetypeCatalog=local
```

Select the **gateway-archetype-camel-ospl** archetype. Then follow the
instructions, defining the *groupId* , *artifactId* and *version* of
your project.

Here is an example of output and user's input (end of each
"`Define value for property...`" line):

``` {.sourceCode .text}
demo@hao:~$ mvn archetype:generate -DarchetypeCatalog=local             
[INFO] Scanning for projects...                                          
[INFO]                                                                   
[INFO]                                                                   
[INFO] Building Maven Stub Project (No POM) 1                            
[INFO]                                                                   
[INFO]                                                                   
[INFO] >>> maven-archetype-plugin:2.2:generate (default-cli) @           
standalone-pom >>>                                                       
[INFO]                                                                   
[INFO] <<< maven-archetype-plugin:2.2:generate (default-cli) @           
standalone-pom <<<                                                       
[INFO]                                                                   
[INFO] --- maven-archetype-plugin:2.2:generate (default-cli) @           
standalone-pom ---                                                       
[INFO] Generating project in Interactive mode                            
[INFO] No archetype defined. Using maven-archetype-quickstart            
(org.apache.maven.archetypes:maven-archetype-quickstart:1.0)             
Choose archetype:                                                        
1: local -> com.adlinktech.gateway.archetypes:gateway-archetype-camel-ospl
 (Creates a new Gateway project using camel-ospl component.)
Choose a number or apply filter (format: [groupId:]artifactId, case sensitive contains): : 1                                                 
Define value for property 'groupId': : org.acme                          
Define value for property 'artifactId': : MyProject                      
Define value for property 'version': 1.0-SNAPSHOT: : 0.0.1-SNAPSHOT      
Define value for property 'package': org.acme: : org.acme                
[INFO] Using property: project-version = 2.0.0                           
Confirm properties configuration:                                        
groupId: org.acme                                                        
artifactId: MyProject                                                    
version: 0.0.1-SNAPSHOT                                                  
package: org.acme                                                        
project-version: 2.0.0                                                   
Y: : Y                                                                  
[INFO]                                                                   
[INFO] Using following parameters for creating project from Archetype:   
gateway-archetype-camel-ospl:2.0.0                                       
[INFO]                                                                   
[INFO] Parameter: groupId, Value: org.acme                               
[INFO] Parameter: artifactId, Value: MyProject                           
[INFO] Parameter: version, Value: 0.0.1-SNAPSHOT                         
[INFO] Parameter: package, Value: org.acme                               
[INFO] Parameter: packageInPathFormat, Value: org/acme                   
[INFO] Parameter: package, Value: org.acme                               
[INFO] Parameter: version, Value: 0.0.1-SNAPSHOT                         
[INFO] Parameter: project-version, Value: 2.0.0                          
[INFO] Parameter: groupId, Value: org.acme                               
[INFO] Parameter: artifactId, Value: MyProject                           
[INFO] project created from Archetype in dir: /home/demo/MyProject       
[INFO]                                                                   
[INFO] BUILD SUCCESS                                                     
[INFO]                                                                   
[INFO] Total time: 31.345s                                               
[INFO] Finished at: Wed Jul 02 15:01:26 CEST 2014                        
[INFO] Final Memory: 10M/207M                                            
[INFO]                                                                   
```

With this example the following hierarchy of directories and files are
created:

``` {.sourceCode .text}
MyProject/
|-- pom.xml
|-- README.txt
`-- src/
    `-- main/
        |-- idl/
        | `-- your_dds_types_definition.idl
        `-- java/
            `-- org/
                `-- acme/
                    `-- GatewayRoutesDefinition.java
```

The generated Maven *pom.xml* file is already configured with
appropriate dependencies, including the Vortex Gateway's camel-ospl
component.

All you have to do is:

1.  Copy or create your IDL files with DDS types definition in
    *src/main/idl* .
2.  Update the *GatewayRoutesDefinition.java* adding your own Camel
    routes definition.
3.  Compile your project with this command:

    `mvn package`

4.  Run your project with this command:

    `mvn exec:java`

(Note that if Vortex OpenSplice is not configured in Single Process

:   mode, you should start the Vortex OpenSplice daemon at first)


