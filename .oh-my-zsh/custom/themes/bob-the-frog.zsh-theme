# Colors chart: https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg
# Inspired from: https://github.com/zthxxx/jovial

REV_GIT_DIR=""

chpwd_git_dir_hook() { REV_GIT_DIR=`command git rev-parse --git-dir 2>/dev/null`; }
add-zsh-hook chpwd chpwd_git_dir_hook
chpwd_git_dir_hook

# rev_parse_find(filename:string, path:string, output:boolean)
# reverse from path to root wanna find the targe file
# output: whether show the file path
rev_parse_find() {
    local target="$1"
    local current_path="${2:-`pwd`}"
    local whether_output=${3:-false}
    local parent_path="`dirname $current_path`"
    while [[ "$parent_path" != "/" ]]; do
        if [ -e "${current_path}/${target}" ]; then
            if $whether_output; then echo "$current_path"; fi
            return 0; 
        fi
        current_path="$parent_path"
        parent_path="`dirname $parent_path`"
    done
    return 1
}


venv_info_prompt() { 
	[ $CONDA_DEFAULT_ENV ] && echo "$FG[242](%{$FG[157]%}$(basename $CONDA_DEFAULT_ENV)$FG[242])%{$reset_color%}"; 
}

get_name() { 
	echo "%{$terminfo[bold]$FG[001]%}[%{$FG[003]%}%n%{$FG[002]%}@%{$FG[004]%}%m%{$FG[001]%}]%{$reset_color%}"
}


current_dir() {
    echo "%{$terminfo[bold]$FG[226]%}%~%{$reset_color%}"
}

get_date_time() {
    date "+%b %d,%l:%M:%S"
}

get_space_size() {
    # ref: http://zsh.sourceforge.net/Doc/Release/Expansion.html#Parameter-Expansion-Flags
    local str="$1"
    local zero_pattern='%([BSUbfksu]|([FB]|){*})'
    local len=${#${(S%%)str//$~zero_pattern/}}
    local size=$(( $COLUMNS - $len ))
    echo $size
}

get_fill_space() {
    local size=`get_space_size "$1"`
    printf "%${size}s"
}

previous_align_right() {
    # CSI ref: https://en.wikipedia.org/wiki/ANSI_escape_code#CSI_sequences
    local new_line='
    '
    local str="$1"
    local align_site=`get_space_size "$str"`
    local previous_line="\033[1A"
    local cursor_back="\033[${align_site}G"
    echo "${previous_line}${cursor_back}${str}${new_line}"
}

align_right() {
    local str="$1"
    local align_site=`get_space_size "$str"`
    local cursor_back="\033[${align_site}G"
    local cursor_begin="\033[1G"
    echo "${cursor_back}${str}${cursor_begin}"
}

py_version(){
	if [[ -n `python --version` ]]; then
        echo  "%{$FG[239]%}using %{$FG[029]%}`python --version`%{$reset_color%} "
    fi
}

git_action_prompt() {
    if [[ -z "$REV_GIT_DIR" ]]; then return 1; fi
    local action=""
    local rebase_merge="${REV_GIT_DIR}/rebase-merge"
    local rebase_apply="${REV_GIT_DIR}/rebase-apply"
	if [[ -d "$rebase_merge" ]]; then
        local rebase_step=`cat "${rebase_merge}/msgnum"`
        local rebase_total=`cat "${rebase_merge}/end"`
        local rebase_process="${rebase_step}/${rebase_total}"
		if [[ -f "${rebase_merge}/interactive" ]]; then
			action="REBASE-i"
		else
			action="REBASE-m"
		fi
	elif [[ -d "$rebase_apply" ]]; then
        local rebase_step=`cat "${rebase_apply}/next"`
        local rebase_total=`cat "${rebase_apply}/last"`
        local rebase_process="${rebase_step}/${rebase_total}"
        if [ -f "${rebase_apply}/rebasing" ]; then
            action="REBASE"
        elif [ -f "${rebase_apply}/applying" ]; then
            action="AM"
        else
            action="AM/REBASE"
        fi
    elif [ -f "${REV_GIT_DIR}/MERGE_HEAD" ]; then
        action="MERGING"
    elif [ -f "${REV_GIT_DIR}/CHERRY_PICK_HEAD" ]; then
        action="CHERRY-PICKING"
    elif [ -f "${REV_GIT_DIR}/REVERT_HEAD" ]; then
        action="REVERTING"
    elif [ -f "${REV_GIT_DIR}/BISECT_LOG" ]; then
        action="BISECTING"
    fi

	if [[ -n "$rebase_process" ]]; then
		action="$action $rebase_process"
	fi
    if [[ -n "$action" ]]; then
		action="|$action"
	fi

    echo "$action"
}

# Timeit
sec_to_human(){
    local sec=$1

    local D=`echo "$sec/86400" | bc`
    local sec=`echo "$sec%86400" | bc`

    local H=`echo "$sec/3600" | bc`
    local sec=`echo "$sec%3600" | bc`

    local M=`echo "$sec/60" | bc`
    local sec=`echo "$sec%60" | bc`

    local S=`echo $sec | cut -d. -f1`
    local Ms=`echo $sec | cut -d. -f2 | sed 's/^0*//'`

    local op=""
    [[ $D > 0 ]] && op=`echo $op ${D}d`
    [[ $H > 0 ]] && op=`echo $op ${H}h`
    [[ $M > 0 ]] && op=`echo $op ${M}m`
    [[ $S > 0 ]] && op=`echo $op ${S}s`
    [[ $Ms > 0 ]] && op=`echo $op ${Ms}ms`

    echo $op
}
preexec() {
  start=$(date +%s.%N)
}

precmd() {
  if [ $start ]; then
    local end=$(date +%s.%N)
    local timeit=`printf "%.3f" $((end-start))`
    local timeit=`sec_to_human $timeit`
    export RPROMPT="%F{247}${timeit}%{$reset_color%}"
    unset start
  fi
}
# endTimeit


VIRTUAL_ENV_DISABLE_PROMPT=true

ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[239]%}on%{$reset_color%} (%{$FG[159]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
GIT_PROMPT_DIRTY_STYLE="%{$reset_color%})%{$FG[202]%}💩 🧹"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$reset_color%})%{$FG[040]%}😌 ✨"

git_action_prompt_hook() {
    if [[ -z "$REV_GIT_DIR" ]]; then return 1; fi
    ZSH_THEME_GIT_PROMPT_DIRTY="`git_action_prompt`${GIT_PROMPT_DIRTY_STYLE}"
}
add-zsh-hook precmd git_action_prompt_hook
git_action_prompt_hook

local BOB_PROMPT_HEAD='╭─$(get_name) %{$FG[239]%}at $(current_dir) $(py_version)$(git_prompt_info)  '
local BOB_PROMPT_FOOT='╰──⮞ $(venv_info_prompt) '
local BOB_PROMPT_HEAD_RIGHT_TIME='$(align_right " `get_date_time`")'

PROMPT="${BOB_PROMPT_HEAD_RIGHT_TIME}${BOB_PROMPT_HEAD}
$BOB_PROMPT_FOOT"
