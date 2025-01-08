#!/usr/bin/env bash
# Wait for database to startup 
sleep 20
./opt/mssql-tools18/bin/sqlcmd -S localhost -U SA -P Anhyeuem2002a@ -i setup.sql