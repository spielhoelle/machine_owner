# ssh $wh 'docker exec machine_owner_db /bin/bash -c "mysqldump -uwordpress -pwordpress machine_owner > /machine_owner-$(date +%Y-%m-%d).sql"'
# ssh $wh "docker cp machine_owner_db:/machine_owner-$(date +%Y-%m-%d).sql ~/www/machine_owner/"
# scp -rp $wh:~/www/machine_owner/machine_owner-$(date +%Y-%m-%d).sql .
OLD_URL=https://mo.tmy.io
NEW_URL=http://localhost:8000
sed "s~$OLD_URL~$NEW_URL~g" machine_owner-$(date +%Y-%m-%d).sql >'dump_updated.sql'
docker cp dump_updated.sql machine_owner_db:/dump_updated.sql
docker exec machine_owner_db /bin/bash -c "mysql -uwordpress -pwordpress machine_owner < /dump_updated.sql"
