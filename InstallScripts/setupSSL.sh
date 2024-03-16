REPOROOT=$(echo $PWD) 

keytool -genkeypair -dname "CN=noaether, O=noae, L=Montreal, S=QC, C=Canada" -alias database -storepass "databaseKeystore" -keyalg RSA -keysize 2048 -validity 365 -keystore $REPOROOT/Database/databaseKeystore.jks 

keytool -genkeypair -dname "CN=noaether, O=noae, L=Montreal, S=QC, C=Canada" -alias server -storepass "serverKeystore" -keyalg RSA -keysize 2048 -validity 365 -keystore $REPOROOT/Server/serverKeystore.jks 

keytool -exportcert -alias server -storepass "serverKeystore" -file $REPOROOT/Server/server.crt -keystore $REPOROOT/Server/serverKeystore.jks
keytool -importcert -noprompt -alias server -storePass "databaseKeystore" -file $REPOROOT/Server/server.crt -keystore $REPOROOT/Database/databaseTruststore.jks

keytool -exportcert -alias database -storepass "databaseKeystore" -file $REPOROOT/Database/database.crt -keystore $REPOROOT/Database/databaseKeystore.jks
keytool -importcert -noprompt -alias database -storePass "serverKeystore" -file $REPOROOT/Database/database.crt -keystore $REPOROOT/Server/serverTruststore.jks

mv $REPOROOT/Database/*.jks $REPOROOT/Database/src/main/resources/
mv $REPOROOT/Server/*.jks $REPOROOT/Server/src/main/resources/


