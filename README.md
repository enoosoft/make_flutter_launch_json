# Make Flutter Launch Json

## Description
This package is a command line tool to create launch.json for debugging Flutter apps in VSCode. 
`deviceId` is set to `flutter devices` command output. Output is written to `.vscode/launch.g.json` in the current directory.

## Usage

```shell
git clone https://github.com/enoosoft/make_flutter_launch_json.git

cd make_flutter_launch_json

dart pub get

dart run bin/make_flutter_launch_json
```

