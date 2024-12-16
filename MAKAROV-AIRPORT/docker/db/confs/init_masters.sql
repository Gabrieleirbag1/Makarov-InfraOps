/*
 * Create the user that will be used for the replica
*/

CREATE USER 'replicator'@'%' IDENTIFIED BY 'toto';
GRANT REPLICATION SLAVE ON *.* TO 'replicator'@'%';

CREATE USER 'gab'@'%' IDENTIFIED BY 'toto';
GRANT ALL PRIVILEGES ON *.* TO 'gab'@'%';

