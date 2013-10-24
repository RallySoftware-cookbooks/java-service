default[:echoserver][:java][:'-D'][:port] = 9999
default[:echoserver][:java][:'-X'][:ms] = '256m'
default[:echoserver][:java][:'-XX'][:UseConcMarkSweepGC] = true
default[:echoserver][:java][:'-'][:server] = nil
default[:echoserver][:java][:args] = ['foo', 'bar']

default[:echoserver2][:java][:'-D'][:port] = 9989
default[:echoserver2][:java][:'-X'][:ms] = '256m'
default[:echoserver2][:java][:'-XX'][:UseConcMarkSweepGC] = true
default[:echoserver2][:java][:'-'][:server] = nil
default[:echoserver2][:java][:args] = ['foo', 'bar']
