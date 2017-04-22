###!
--- gitrelease ---

Released under MIT license.

by Gustavo Vargas - @xgvargas - 2017

Original coffee code and issues at: https://github.com/xgvargas/gitrelease
###

yargs   = require 'yargs'
Promise = require 'bluebird'
chalk  = require 'chalk'
path    = require 'path'
request = require 'request'
inquirer = require 'inquirer'

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
# console.log "==== opcoes\n", argv

cfg =
    changesFile    : 'CHANGELOG.md'
    usePrepend    : yes
    packageFile   : 'package.json'
    cordovaFile   : false
    runScript     : false
    issuePattern  : '''(closes|close|closed|fix|fixed|fixes)\s+((?:\w+\/\w+)?#\d+)'''
    personalToken : false
    deployCmd     : false
    groups:
        Fixes: ['fixes', 'fix']
        Features: ['features', 'feat']

try
    cfg = Object.assign cfg, require path.join process.cwd(), './.gitrelease.json'
# console.log "==== configuracao\n", cfg



# TODO criar mensage baseado no historico
message = 'Oi, sou gordo....'



console.log chalk.white.bold '\n\nRelease Message...\n\n'
console.log message
console.log '\n-------\n'

questions = [
    type: 'confirm'
    name: 'edit'
    default: no
    message: 'Do you want the edit this message text?'
,
    type: 'editor'
    name: 'message'
    default: message
    message: 'Please, open the editor, edit, save and EXIT'
    when: (res) -> res.edit
,
    type: 'list'
    name: 'update'
    choices: ['keep current', 'patch', 'minor', 'major']
    default: 'patch'
    message: 'Select intended update of version'
,
    type: 'confirm'
    name: 'deploy'
    default: no
    message: 'Confirm deploy?'
    when : -> cfg.deployCmd
,
    type: 'confirm'
    name: 'go'
    default: no
    message: 'Your change to review.... Execute?'
]

inquirer.prompt questions
.then (res) ->

    res.message = message unless res.edit

    console.log "=== respostas: \n", res

    unless res.go
        console.log '\nAborting...\n'
        process.exit 0


    # TODO.....


    if cfg.packageFile
        console.log "Updating NPM package version: #{chalk.yellow cfg.packageFile}"
        # TODO...

    if cfg.changesFile
        console.log "Appending changes to file: #{chalk.yellow cfg.changesFile}"
        # TODO...

    if cfg.cordovaFile
        console.log "Updating cordova version. file: #{chalk.yellow cfg.cordovaFile}"
        # TODO...
        # caso queira editar o config.xml do cordova
        # http://xmlstar.sourceforge.net/
        # xmlstarlet ed -u "_:widget/@version" -v "4.5.9" config.xml

    if cfg.runScript
        console.log "Executing hook: #{chalk.green cfg.runScript}"
        # TODO...

    if res.deploy
        console.log "Deploying... cmd: #{chalk.green cfg.deployCmd}"
        # TODO...


# http://stackoverflow.com/questions/12219604/list-git-tag-names-dates-and-messages
# http://stackoverflow.com/a/12083016/849117
# git log --no-walk --tags --pretty="%h %d %s" --decorate=full
# git log v0.1.2..HEAD --format="%d %s"

# http://stackoverflow.com/questions/18350447/is-there-a-way-to-prepare-git-tag-messages

# curl --header "PRIVATE-TOKEN: XXXXXXXXXXXXX" "https://gitlab.example.com/api/v4/projects"
