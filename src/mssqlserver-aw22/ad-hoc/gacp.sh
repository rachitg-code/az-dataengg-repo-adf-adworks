# gacp(){
#  git status
#  git add .
#  git status
#  git commit -m "$1"
#  git status
#  git push
#  git status
# }

	  
# gacp(){
#  git status
#  git pull
#  git status
#  git add .
#  git status
#  git commit -m "$1"
#  git status
#  git push
#  git status
# }

gacp(){
    echo '>>>>>S1 >> Pull-Status'
    git status
    git pull
    git status
    if [ -f .git/MERGE_HEAD ]; then
        echo ">>>>>S1 >>MergeConflict >> Stopping"
    else
        echo '>>>>>S2 >> Add'
        git add .
        git status
    if git diff --cached --exit-code --quiet; then
        echo ">>>>>S1 >>NoChangesForCommit >> Stopping"
    else
        echo '>>>>>S3 >> Commit'
	    git commit -m "$1"
	    git status
	    echo '>>>>>S4 >> Push'
	    git push
	    git status
    fi
 fi
}