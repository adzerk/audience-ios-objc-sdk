# Examples

These two examples projects illustrate how VelocidiSDK can be used in a project. ObjcExample is written in Objective-C and SwiftExample is written in Swift.

## Instructions

Setup should be really simple, all that is needed is to open the workspace (located at the project's root) with Xcode. After that, in the project's root, run `pod install --project-directory=Examples/` and it should be ready to go.

### Capture HTTP events

To see the HTTP events sent by the SDK, have the configuration url's point to `http://localhost:8080` and then run a netcat instance that replies to all request with a `200 OK` response code.

```bash
$ while true; do echo -e 'HTTP/1.1 200 OK\r\n\r\n' | nc -i 1 -l 8080; done
```

_Netcat has limited functionality and this command will wait 1 second before replying(in order to wait for all data to be transmitted ), so the it might feel a little slugish. You can also use online mock HTTP clients, like [Mocky](https://www.mocky.io/)_ 
