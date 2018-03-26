Introduction
============

Vortex Gateway addresses the problem of making data seamlessly flow
across systems and technologies while adapting format, content and QoS.
The Vortex Gateway is the best choice for integrating DDS-based systems
with other messaging technologies, such as JMS, as well as for
integrating with proprietary and Web Technologies such as W3C Web
Services and RESTful Web Services.

By leveraging **Apache Camel**, the Vortex Gateway comes with
off-the-shelf support for more than eighty connectors including one for
the Vortex OpenSplice DDS, as well as transports that are standard in
Enterprise Computing and Web applications.

![**The Vortex Gateway
architecture**](Gateway_architecture.png){width="100%"}

For more information about Apache Camel, please refer to:

> -   [](http://camel.apache.org/)
> -   [](http://camel.apache.org/manual.html) (Apache Camel manuals)
> -   [](http://camel.apache.org/components.html) (list of
>     available protocols)

Below is an illustration of a typical use case of Vortex Gateway.

![**A Vortex Gateway Use Case**](Gateway_use_case.png){width="100%"}

Here, Vortex Gateway is used to get Radar Tracks data from different
radars *via* DDS or JMS.

Radar Tracks from JMS are routed to DDS and all Tracks are received and
classified by Classifier. The Classifier will publish Classification
data on DDS.

Vortex Gateway also routes Radar Tracks and Classification data from DDS
to an external Ajax-based display *via* a REST endpoint.
