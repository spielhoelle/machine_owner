# Optional make a last-commit deplyment
# git stash

# echo "################# Copy files to server #################"
# rsync -riP --exclude '.DS_Store' --exclude '.swp' --exclude '.git' --exclude '.htaccess' --exclude '.sql' --delete . $wh:/root/www/machine_owner/ | grep "f.sT...."

sshqfunc() { echo "bash -c $(printf "%q" "$(declare -f "$@"); $1 \"\$@\"")"; }
work() {
	echo "################# Restart docker containers #################"
	docker-compose -f /root/www/machine_owner/docker-compose.yml -f /root/www/machine_owner/docker-compose.prod.yml down
	docker-compose -f /root/www/machine_owner/docker-compose.yml -f /root/www/machine_owner/docker-compose.prod.yml up
}

ssh $wh "$(sshqfunc work)"

# Optional get stash back if you made last-commit deployment
# got stash pop
