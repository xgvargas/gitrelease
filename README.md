# gitrelease

gitRelease generates tag messages and CHANGELOG files with messages collected from your commits since last tag released.

## instalation

```bash
npm i -g gitrelease
```

## usage

## configuration

Create a file called `.gitrelease.json` on the root of your project to hold your configuration. Bellow is the default configuration, you need to include only the keys you want to change. If a `.gitrelease.json` is not found then the default one will be used.

key           | default      | description
----          | ------       | -----
changefile    | CHANGELOG.md | set to false if you don´t want to append changes to a file
usePrepend    | true         | true if you want to "append" to beggining of the file
packagefile   | package.json | set to false if you don´t want to set package.json file version to the tag version
cordovafile   |              | cordova config.xml file to have its widget version updated or false if no desired
runscript     |              | a script to be executed with version and message file path as parameters
issuePattern  | see bellow   | regex pattern to identify fixes and closes in git commits
personalToken |              | personal token to github or gitlab

This is the standard regex to identify references to issues:

```
"(closes|close|closed|fix|fixed|fixes)\s+((?:\w+\/\w+)?#\d+)"
```

If any match is found and `personalToken` is supplied then the title of such issue will be retrieved and will replace the issue reference itself.

:bangbang: :bangbang: Since the file `.gitrelease.json` can contain personal and unsafe information you MUST remember to include it into your `.gitignore` and `.npmignore` files!!! :bangbang: :bangbang:

```
# group of changes to generate messages. The arrays contain the trigger that will include message
# to the group named after the keys. Example, commit content:
#
# Any text.....
# fix: This fix the error #12
#
# will render like:
# Fixes:
#     * This fix the error #12
groups:
    Fixes:
        - fixes
        - fix
    Features:
        - features
        - feat
```
