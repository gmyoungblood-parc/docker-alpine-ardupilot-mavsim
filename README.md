# MAVSim ArduPlane Container

This is the Dockerfile to setup the current public version of MAVSim in an Alpine Linux container with ArduPilot SITL. This uses ArduPlane.

**Note: We all use Macs, so this by defaults work of MacOS, so you may have to tweak for Windows and Linux**

### Postgres Pre-requisite

For logging, a Postgres database is needed. If one is not setup then logging will not record anything.

#### Postgres Container Setup using Kitematic

1. Click on the `+NEW` button and search for "postgres"
2. Use the Official postgres container (the one with the elephant logo below) <br />
![](https://raw.githubusercontent.com/ServiceStack/Assets/master/img/livedemos/techstacks/postgresql-logo.png)<br />
3. Stop the container from running and add `POSTGRES_PASSWORD` to the **Environmental Variables**. Set it to something secure and rememberable. `SAVE` this change.
4. With the container running, open a terminal using the `EXEC` button. In that shell, become the postgres user<br /><br />
`# su postgres`<br /><br />
then open postgres

```
     # psql
     psql (9.6.4)
     Type "help" for help.
     postgres=#
```
5. Create a database then exit with `\q`
```
     postgres=# CREATE DATABASE apm_missions;
     CREATE DATABASE
     postgres=# \q
```
6. Close the terminal, you now have a working local version of the Postgres database. Be mindful that it may not be persistent, so be sure to learn about `pg_dump` if you want to save and eventually restore data.

#### Postgres on AWS

You can also setup a cloud hosted Postgres database on the Amazon Cloud, which can be persistent and backed-up regularly. See [Amazon RDS for PostgreSQL](https://aws.amazon.com/rds/postgresql/) for detailed information.

_Note: MAVSim by default writes a lot of data to a database, so be careful of lag if using a remote database. They are better setup as a follower to a local database._

#### Useful database tool

If you want to look at data on your database and edit or test access and data, then take a look at [pgAdmin](https://www.pgadmin.org/) (highly recommended) or the FREE version of [Valentina Studio](https://www.valentina-db.com/en/valentina-studio-overview).


### Setup Container  

This is pre-build on Docker Cloud, so if you need to adjust please look at the `container/develop` in the [MAVSim Public repository](https://gitlab.com/gmyoungblood-parc/mavsim-public)  


*Containers can be volatile, so please be sure setup to save changes if you want to preserve your work.*

### Running mavsim with ArduPilot/ArduPlane
1. Running the container will startup a running MAVSim instance. Configure via the container environment variables. 
2. Alternatively, one can open (i.e., `EXEC` button on Kitematic or `docker exec` on command line) a shell for mavsim and `cd /mavsim` (you should already be there, but just in case). Run `./mavsim.py` in that shell. MAVSim will run ArduPilot and everything else for you. If you need to stop MAVSim, use `Control-C`. 

*Note: You will have to kill all mavsim, simvehicle and jsbsim instances before running your own as described in 2.*

---
The mavsim-arduplane Docker Container is maintained by G. Michael Youngblood at the Palo Alto Research Center (PARC, a Xerox company) in California. It is licensed under [GPLv3](https://www.gnu.org/licenses/gpl-3.0.en.html).
