#!/usr/bin/env python

import lldb
import tempfile

def process(debugger, command, result, internal_dict):
    lldb.debugger.HandleCommand("""
    expr -l swift --
    func $process<T>(path: String, _ object: T) {
        func scanningArray<U>(object: U?) -> [Any]? {
            guard let object = object else { return nil }

            let mirror = Mirror(reflecting: object)
            if mirror.children.count == 0 {
                return nil
            }

            var array: [Any] = []
            mirror.children.forEach { child in
                array.append(scan(object: child.value))
            }
            return array
        }

        func scanning<U>(object: U?) -> [String: Any]? {
            guard let object = object else { return nil }

            let mirror = Mirror(reflecting: object)
            if mirror.children.count == 0 {
                return nil
            }

            var dict: [String: Any] = [:]
            mirror.children.forEach { child in
                guard let label = child.label else { return }

                dict[label] = scan(object: child.value)
            }
            return dict
        }

        func scan<U>(object: U) -> Any {
            let mirror = Mirror(reflecting: object)
            if let label = mirror.children.first?.label, label.hasPrefix("["), label.hasSuffix("]") {
                return scanningArray(object: object) ?? []
            }
            else {
                return scanning(object: object) ?? String(describing: object)
            }
        }

        func json(object: Any) -> String {
            if let data = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted) {
                return String(data: data, encoding: .utf8) ?? ""
            }
            else {
                return String(describing: object)
            }
        }

        let converted = scan(object: object)
        let _json = json(object: converted)
        print(_json)
        try! _json.writeToFile(path, atomically: true, encoding: .utf8)
        print(path)
    }
    """.strip())
    path = tempfile.mktemp() + '.json'
    lldb.debugger.HandleCommand('expr -l swift -- $process("' + path + '", ' + command + ')')

def __lldb_init_module(debugger,internal_dict):
    debugger.HandleCommand("command script add -f json.process json")
    print("json command enabled.")
