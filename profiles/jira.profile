# works with https://github.com/Netflix-Skunkworks/go-jira

function jira_see_all_boards() {
    jira req "/rest/agile/1.0/board?projectKeyOrId=BOS"
}
alias jira_see_all_boards=jira_see_all_boards

function jira_see_particular_board() {
    jira req "/rest/agile/1.0/board/$1"
}
alias jira_see_particular_board=jira_see_particular_board

function jira_papi_backlog() {
    jira req "/rest/agile/1.0/board/36/issue?jql=statusCategory=2" -t table
}
alias jira_papi_backlog=jira_papi_backlog

function jira_papi_in_progress() {
    jira req "/rest/agile/1.0/board/36/issue?jql=statusCategory=4" -t table
}
alias jira_papi_in_progress=jira_papi_in_progress

function jview() {
    # e.g. jview bos-666
    # for this to work you need to install pandoc and lynx
    jira view $1 | pandoc | lynx --stdin
}

function jjview() {
    jview $(git_current_branch | grep -o -e '[^0-9]*[0-9]*')
}
