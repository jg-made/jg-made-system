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

function jira_what_am_i_doing() {
    JIRA_BOARD=36
    JIRA_NAME=$(jira session | grep -e '^name' | grep -o '[a-z]*[\.].*$')
    echo "Fetching any issues on board #$JIRA_BOARD assigned to you...$JIRA_NAME"
    echo "ACTIVE"
    jira req "/rest/agile/1.0/board/$JIRA_BOARD/issue?jql=statusCategory=4%20AND%20assignee%20%3D%20$JIRA_NAME" -t table
    echo "BACKLOG"
    jira req "/rest/agile/1.0/board/$JIRA_BOARD/issue?jql=statusCategory=2%20AND%20assignee%20%3D%20$JIRA_NAME" -t table
}
