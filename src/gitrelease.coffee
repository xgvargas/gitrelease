###!
--- gitrelease ---

Released under MIT license.

by Gustavo Vargas - @xgvargas - 2017

Original coffee code and issues at: https://github.com/xgvargas/gitrelease
###

yargs   = require 'yargs'
Promise = require 'bluebird'
colors  = require 'colors'
path    = require 'path'
request = require 'request'
# execAsync       = Promise.promisify require('child_process').exec
# {exec} = require 'child_process'
# {writeFileSync} = require 'fs'


argv = yargs
.version require('../package.json').version
.usage 'Usage: $0 [options] [path]'
.help 'help'
.alias 'h', 'help'
# .epilog ''
.strict yes
# .options
#     'global': {type:'boolean', alias:'g', describe:'Work with global npm packages'}
#     'concurrency': {type:'number', default:8, describe:'Set the concurrencity number (1-50)'}
.argv
# console.dir argv

if argv._.length > 1
    yargs.showHelp()
    process.exit 1


# http://stackoverflow.com/questions/12219604/list-git-tag-names-dates-and-messages
# http://stackoverflow.com/a/12083016/849117
# git log --no-walk --tags --pretty="%h %d %s" --decorate=full
# git log v0.1.2..HEAD --format="%d %s"

# caso queira editar o config.xml do cordova
# http://xmlstar.sourceforge.net/
# xmlstarlet ed -u "_:widget/@version" -v "4.5.9" config.xml

# http://stackoverflow.com/questions/18350447/is-there-a-way-to-prepare-git-tag-messages

# curl --header "PRIVATE-TOKEN: XXXXXXXXXXXXX" "https://gitlab.example.com/api/v4/projects"
