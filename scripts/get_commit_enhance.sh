#!/bin/bash 

# git fetch

# branch_list=$(git branch -a)


# for branch in $branch_list;

# do
# # 
# 	if [[ (!$branch =~ "remotes/origin/") || $branch =~ "HEAD" ]]; then
# 		#statements
# 		continue
# 	fi

# 	branch_name=${branch##'remotes/origin/'}

# 	echo $branch_name


# # 	git fetch

# # 	commit_id=$(git rev-parse origin/$branch_name)
# # 	echo "-------远程仓库当前的commit_id--------"
# # 	echo $commit_id


# # 	git checkout -f $commit_id
# # 	echo "-------切换到指定commit_id--------"
# # 	echo $commit_id


# # 	old_commit=$(git log --pretty=format:"%cd [%an]: %s" --date=short --since="1 year ago")
# # 	echo "-------21天之内 commit log--------"
# # 	echo $old_commit



# #     commit_log=$(git log --pretty=format:"<p style=\"margin: 0; margin-left: 20px; line-height: 25px; color: #7674A2;\">%cd &nbsp;&nbsp; [$branch_name] &nbsp;&nbsp; %an: &nbsp; %s</p>\n<hr size=1 style=\"border-color: #5C5C5C; margin: 0; margin-bottom: 2px;\"/>\n" --date=format:"%F_%T" --since="1 day ago")
# # 	echo "-------1天之前到现在的 commit log--------"
# # 	echo $commit_log



# # 	echo "======================="

# # 	echo "======================="
# # 	echo "======================="
# # 	echo "======================="
# # 	echo "======================="


# done





# git for-each-ref --shell --format='git log --oneline %(refname) ^origin/master' refs/heads/

# git for-each-ref --format='%(objectname) %(objecttype) %(refname)'

# git for-each-ref --shell \
#   --format='git log --oneline %(refname) ^origin/master' \
#   refs/heads/



# ^origin/master 匹配到master指针

for branch in $(git for-each-ref --format='%(refname)' refs/remotes);


do

	echo $branch

    git log --oneline "$branch" --pretty=format:"%cd [%an]: %s" --date=short --since="2 week ago"

    echo -e "\n"

done











