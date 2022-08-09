# database-migration-tool

Database migration made simple.

## Database support

- MySQL
- SQLite

## Functions

### Validations

- Only run sql querys that has not been run before
- Checks that all checksum are same on installed and on the scripts
- New versions can't be inserted between two installed scripts

## Command line

```
<command> --changelog-file=config.yaml migrate
```

commands:

| command | Description |
| ------- | ----------- |
| clean   |             |
| info    |             |
| migrate |             |

## Changelog file

yaml file with changelog settings for the database migrations

example.yaml

```yaml
database:
  database_plugin: mysql
  host: localhost
  port: 3306
  username: ${env:MYSQL_USER}
  password: ${env:MYSQL_PASS}

xxxxxxxx:
  allow_clean: True

databaseMigrations:
  - changeSet: 1
    author: Mike <mike@email.com>
    changes:
    sqlFile: baseline.sql
  - changeSet: 2
    author: Matt <matt@email.com>
    changes:
    sqlFile: test.sql
    parameters:
      - userName: test
      - email: test@email.com
  - changeSet: 3
    author: Matt <matt@email.com>
    changes:
    scriptFile: test.py

parameters:
  - tableName: users
  - name: test
```

baseline.sql

```sql
--- sql with parameter inputs from changelog file
CREATE TABLE ${tableName} (
  name VARCHAR(30) NOT NULL,
  PRIMARY KEY(name)
);

INSERT INTO ${tableName} (name) VALUES ('${name}');

--- sql with parameter input from enviroment variables
CREATE TABLE ${env:TABLE_NAME} (
  test VARCHAR(10) NOT NULL,
  PRIMARY KEY(test)
);

--- normal sql
CREATE TABLE email (
  email VARCHAR(255) NOT NULL,
  PRIMARY KEY(email)
);
```

## Tables

### database-change-log

Table for tracking changes to the database

| Column       | Data type    | Description                               |
| ------------ | ------------ | ----------------------------------------- |
| id           | INT          | ID                                        |
| description  | VARCHAR(255) | description from the script               |
| script       | VARCHAR(255) | filename of the script                    |
| checksum     | VARCHAR(64)  | SHA256 checksum of the script file        |
| installed_on | TIMESTAMP    | date and time when successfully migrtated |
| total_querys | INT          | total sql querys in file                  |
| done_querys  | INT          | number of last successful query           |
| success      | INT          | 1 for success 0 for failure               |

### database-change-lock

Table for storing database lock to prevent only one instanse of xxx to be running against the database

| Column    | Data type    | Description                    |
| --------- | ------------ | ------------------------------ |
| id        | INT          | ID of the lock                 |
| locked    | INT          | 1 if locked otherwise 0        |
| granted   | DATETIME     | Date and time lock was granted |
| locked_by | VARCHAR(255) | DB username                    |
