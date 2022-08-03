# database-migration-tool

## functions

### validations

- Checks that all checksum are same on installed and on the scripts
- New versions can't be inserted between two installed scripts

## tables

### database-change-log

Table for tracking done changes to the database

| Column       | Data type    | Description                               |
| ------------ | ------------ | ----------------------------------------- |
| id           | INT          | ID                                        |
| version      | INT          | version from the script                   |
| description  | VARCHAR(255) | description from the script               |
| script       | VARCHAR(255) | filename of the script                    |
| checksum     | VARCHAR(64)  | SHA256 checksum of the script file        |
| installed_on | TIMESTAMP    | date and time when successfully migrtated |
| success      | INT          | 1 for success 0 for failure               |

### database-change-lock

Table for storing database lock to prevent only one instanse of xxx to be running against the database

| Column    | Data type    | Description                    |
| --------- | ------------ | ------------------------------ |
| id        | INT          | ID of the lock                 |
| locked    | INT          | 1 if locked otherwise 0        |
| granted   | DATETIME     | Date and time lock was granted |
| locked_by | VARCHAR(255) | DB username                    |
