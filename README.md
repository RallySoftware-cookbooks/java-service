## Description
Contains an LWRP for managing Java processes as Bluepill services.

## Requirements
### Platform
* Centos 6.4

## Recipes
### default
Includes the following recipes and should be included before using the java_service resource

* java
* bluepill

### Dependencies
* java
* bluepill

## Resources and Providers
### java_service

If you need to specify the class.

```ruby
java_service 'echoserver' do
  main_class 'EchoServer'
  classpath '/path/server.jar'
  user 'theuser'
end
```

If you have an executable jar.

```ruby
java_service 'echoserver' do
  jar '/path/server.jar'
  user 'theuser'
end
```

### LWRP attributes:
* `service_name` -  The name of your service (this is the 'name' attribute of the LWRP)
* `user` - The user that will run your service
* `main_class` - The Java class to execute (one of `main_class` or `jar` is required)
* `classpath` - ':' delimited string of jars and directories containing classes needed.
* `jar` - The path to an executable Jar file.
* `system_properties` - a Hash of properties to be passed in as `-D` params. For example `{'foo' => 'bar'}` will produce `-Dfoo=bar`
* `standard_options` - a Hash of properties to be passed in as `-` params. For example `{'server' => nil, 'ea' => 'com.wombat.fruitbat'}` will produce `-server -ea:com.wombat.fruitbat`
* `non_standard_options` - a Hash of properties to be passed in as '-X' params. For example `{'ms' => '128m', 'int' => nil, 'bootclasspath' => '/some/path'}` will produce `-Xms128m -Xint -Xbootclasspath:/some/path`
* `hotspot_options` - a Hash of properties to be passed in as '-XX' params. For example `{'FlightRecorder' => true, 'LargePageSizeInBytes' => '128m'}` will produce `-XX:+FlightRecorder -XX:LargePageSizeInBytes=69m`
* `args` - an array of arguments to pass to the at the end of the command line
* `working_dir` - the working directory for the Java process
* `pill_file_dir` - the location to place the bluepill pill file. If not specified uses the default from bluepill.

Instead of passing in `system_properties`, `standard_options`, `non_standard_options`, `hotspot_options`, `args` you can set node attributes like:

```ruby
default[:echoserver][:java][:'-D'][:port] = 9999
default[:echoserver][:java][:'-X'][:ms] = '256m'
default[:echoserver][:java][:'-XX'][:UseConcMarkSweepGC] = true
default[:echoserver][:java][:'-'][:server] = nil
default[:echoserver][:java][:args] = ['foo', 'bar']
```

Note that 'echoserver' is ths value of `service_name` as specified in the `java_service` provider. This is useful if you want different values on different nodes.


## License
Copyright (C) 2013 Rally Software Development Corp

Distributed under the MIT License.
