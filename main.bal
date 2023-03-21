import ballerina/http;
import ballerina/os;
import ballerina/io;

listener http:Listener httpListener = new (9090);

service / on httpListener {
    resource function get greeting() returns string|error {
        os:Process|os:Error process = os:exec({value: "bal", arguments: ["version"]});

        if process is os:Process {
            byte[]|os:Error output = process.output(io:stdout);
            if output is byte[] {
                return string:fromBytes(output);
            }
            if output is os:Error {
                return output;
            }
        }
        if process is os:Error {
            return process;
        }
    }

    resource function get greeting/[string name]() returns string {
        return "Hello " + name;
    }

}

