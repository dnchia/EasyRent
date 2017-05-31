# EasyRent
## Description
Project developed for the subject EI1027 at UJI

## Prerequisites

* Maven 3.x
* Java 8
* Free 8080 port

The application requires write permissions in:

* `/var/lucene` Where the search indexes are being stored
* `/var/easyrent` Application persistent files

## How to run

* **-- Option 1:** Run `main()` method from `Application.class`. This option is more suitable to failures, due to IDE dependency.
* **-- Option 2:** Requires Maven. Follow the steps [here](https://maven.apache.org/install.html). Once installed and added to the system path, run `mvn spring-boot:run`.

For both options, after running the app, browse to [localhost:8080](http://localhost:8080) to start using the application.

## Authors
* Alberto González [@albertogonper](https://github.com/albertogonper)
* Daniel Chía [@dnca](https://github.com/dnca)
