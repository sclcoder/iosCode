
# 遍历所有分支获取git提交日志


IOS_WORKSPACE_PATH=$(pwd)
ANDROID_WORKSPACE_PATH=$(pwd)

LOG_DIR=$(pwd)"/log"
COMMIT_PATH="$LOG_DIR/commit.log"
TEM_COMMIT="$LOG_DIR/tmp.log"
TEM_COMMIT_DETAIL="$LOG_DIR/detail_log/tmp_d.log"


<<-EOF
Linux
date -d +2day +%Y%m%d-%H%M%S 当前时间+2天
date -d -2day +%Y%m%d-%H%M%S 当前时间-2天
如：20220328-183057 

MacOS
date -v-2d +%Y%m%d-%H%M%S 

EOF


COMMIT_DETAIL_PATH="$LOG_DIR/cd_$(date -v-2d +%Y%m%d-%H%M%S ).log"
IOS_BLACKLIST_PATH="$LOG_DIR/black_ios.list"
ANDROID_BLACKLIST_PATH="$LOG_DIR/black_android.list"

function get_commit(){

    # 调用函数传入的参数
    TEM_COMMIT=$1
    COMMIT_PATH=$2
    BLACKLIST_PATH=$3

    # 
    git fetch

    # 所有的远程分支
    branch_list=$(git branch -a)

    # 黑名单
    black_list=$(cat $BLACKLIST_PATH)

    for branch in $branch_list;
    do
        # [[]] 检测某个条件是否成立
        # 可以使用 [[ 命令的 =～ 操作符来判断某个字符串是否包含特定模式: 判断右边的模式是否为左边字符串的子字符串
        # https://segmentfault.com/a/1190000022102207

        ## 跳过本地的分支
        if [[ !($branch =~ "remotes/origin/") || $branch =~ "HEAD" ]]; then
            continue
        fi

        # ${VALUE#*.}或${VALUE##*.}：删除VALUE字符串中以分隔符“.”匹配的左边字符，保留右边字符。
        branch_name=${branch##'remotes/origin/'}

        if [[ $black_list =~ "[$branch_name]" ]]; then
            continue
        fi
        # git checkout .
        # git clean -xdf
        # git reset --hard HEAD
        # git checkout -b $branch_name - t "origin/$branch_name"
        # git checkout $branch_name
        # git fetch
        # git pull origin $branch_name

        git fetch
        commit_id=$(git rev-parse origin/$branch_name)
        git checkout -f $commit_id

        old_commit=$(git log --pretty=format:"%cd [%an]: %s" --date=short --since="21 day ago")
        if [[ ${#old_commit} == 0 ]]; then
            echo "[$branch_name]" >> $BLACKLIST_PATH
            continue
        fi

        commit_log=$(git log --pretty=format:"<p style=\"margin: 0; margin-left: 20px; line-height: 25px; color: #7674A2;\">%cd &nbsp;&nbsp; [$branch_name] &nbsp;&nbsp; %an: &nbsp; %s</p>\n<hr size=1 style=\"border-color: #5C5C5C; margin: 0; margin-bottom: 2px;\"/>\n" --date=format:"%F_%T" --since="1 day ago")
        if [[ ${#commit_log}  == 0 ]]; then
            continue
        fi
        
        echo -e $commit_log > $TEM_COMMIT
        cat $TEM_COMMIT | while read commitline
        do
            echo $commitline >> $COMMIT_PATH
        done
        
        echo $branch_name >> $COMMIT_DETAIL_PATH
        commit_detail_log=$(git log --pretty=format:"%cd [%an]: %s\n" --since="1 day ago")
        echo -e $commit_detail_log > $TEM_COMMIT_DETAIL
        cat $TEM_COMMIT_DETAIL | while read commitline
        do
            echo $commitline >> $COMMIT_DETAIL_PATH
        done
        
    done
}

echo "" > $COMMIT_PATH
echo '<div style="margin-left: 40px;" >' >> $COMMIT_PATH
echo '<b style="margin-left: 10px;color: #003399; line-height: 35px; font-size: 16px;"> All code changes for iOS in 24 hours</b>' >> $COMMIT_PATH
echo '<hr style="size: 2; border-color: #75D4DB;"/>' >> $COMMIT_PATH
echo '[iOS]' >> $COMMIT_DETAIL_PATH
cd $IOS_WORKSPACE_PATH
get_commit $TEM_COMMIT $COMMIT_PATH $IOS_BLACKLIST_PATH

echo '<br/>' >> $COMMIT_PATH
echo '<br/>' >> $COMMIT_PATH
echo '<br/>' >> $COMMIT_PATH

echo '<b style="margin-left: 10px;color: #003399; line-height: 35px; font-size: 16px;">All code changes for Android in 24 hours</b>' >> $COMMIT_PATH
echo '<hr style="size: 2; border-color: #6678B1;"/>' >> $COMMIT_PATH
echo '[Android]' >> $COMMIT_DETAIL_PATH
cd $ANDROID_WORKSPACE_PATH
get_commit $TEM_COMMIT $COMMIT_PATH $ANDROID_BLACKLIST_PATH
echo '</div>' >> $COMMIT_PATH

