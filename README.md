## Description
Contains an LWRP for managing Java processes as Bluepill services.

## Requirements
### Platform
* Centos 6.4

### Dependencies
* java
* bluepill

## Resources and Providers
### java_service

```ruby
java_service 'echoserver' do
  main_class 'EchoServer'
  classpath '/root/server.jar'
  user 'root'
end
```

### LWRP attributes:
* `main_class` - The Java class in your classpath that contains the 'main' method.
* `classpath` - ':' delimited string of jars and directories containing classes needed.
* `user` - The user to run your service as.


## License
Copyright (C) 2013 Rally Software Development Corp

Distributed under the MIT License.
