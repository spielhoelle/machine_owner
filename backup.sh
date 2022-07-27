echo "Backup DB"
docker exec machine_owner_db /bin/bash -c "mysqldump -uwordpress -pwordpress machine_owner > machine_owner-$(date +%Y-%m-%d).sql"
dumpfile=$(docker exec machine_owner_db ls / | grep ".sql" | tail -n 1)
echo $dumpfile
docker cp machine_owner_db:$dumpfile .
