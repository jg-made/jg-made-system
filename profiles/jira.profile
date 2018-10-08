# works with https://github.com/Netflix-Skunkworks/go-jira

# use `jira view bos-666` to see a particular issue in detail

function jira_see_all_boards() {
    jira req "/rest/agile/1.0/board?projectKeyOrId=BOS"
}
alias jira_see_all_boards=jira_see_all_boards

function jira_see_particular_board() {
    jira req "/rest/agile/1.0/board/$1"
}
alias jira_see_particular_board=jira_see_particular_board

function jira_papi_backlog() {
    jira req "/rest/agile/1.0/board/29/issue?jql=statusCategory=2" -t table  
}
alias jira_papi_backlog=jira_papi_backlog

function jira_papi_in_progress() {
    jira req "/rest/agile/1.0/board/29/issue?jql=statusCategory=4" -t table  
}
alias jira_papi_in_progress=jira_papi_in_progress
