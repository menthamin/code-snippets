**** Examples

The following examples are provided to help users get started with gRPC-Go.
They are arranged as follows:

* `helloworld` - a simple example showing a basic client and server
* `routeguide` - a more complicated example showing different types of streaming RPCs
* `features` - a collection of examples, each focused on a single gRPC feature

`data` is a directory containing data used by the examples, e.g. TLS certificates.


- Reference: https://grpc.io/docs/languages/go/quickstart/


Test
```bash
cd helloworld
go run greeter_server/main.go
## From another terminal
go run greeter_client/main.go --name=Alice

>>
Greeting: Hello Alice
Greeting: Hello again Alice
````
