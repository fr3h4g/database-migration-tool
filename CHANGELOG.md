# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this
project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Added command "info" to display status information on migartions.
- Added command "clean" to drop all tables in the database.
- Added command "migrate" to execute all database migrations.
- Added option "-d/--directory" for changing default directory for sql scripts and config.
- Added option "-c/--config-file" for changing default config file.
- Added option "--dry-run" for displaying sql querys and no execution.
