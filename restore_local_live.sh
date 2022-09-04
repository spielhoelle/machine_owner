# local
echo "Replace wordpress domain in dumpfile"
dumpfile=$(ls | grep ".sql" | tail -n 1)
OLD_URL=http://localhost:8000
NEW_URL=https://mo.tmy.com
rm -f dump_updated.sql
sed "s~$OLD_URL~$NEW_URL~g" $dumpfile >'dump_updated.sql'
# docker cp dump_updated.sql machine_owner_db:/
# docker exec machine_owner_db /bin/bash -c "mysql -uwordpress -pwordpress machine_owner_db < /dump_updated.sql"

# echo "Copy uploads folder in server"
# rsy tommy@81.169.157.36:/var/www/emile/wp-content/uploads wp-content/
# rsy tommy@81.169.157.36:/var/www/emile/wp-content/themes wp-content/

# # remote
# dumpfile=$(ls | grep ".sql" | tail -n 1)
# sed "s~$OLD_URL~$NEW_URL~g" $dumpfile >$dumpfile
# echo "Move dump to server and inside docker container and insert dump into DB"
scp -rp dump_updated.sql $wh:/
ssh $wh docker cp /dump_updated.sql machine_owner_db:/
# ssh $wh docker exec machine_owner_db /bin/bash -c "dumpfile=$(ls / | grep ".sql" | tail -n 1)"
ssh $wh 'docker exec machine_owner_db /bin/bash -c "mysql -uwordpress -pwordpress machine_owner_db < /dump_updated.sql'
