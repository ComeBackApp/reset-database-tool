#### The object of the project is to have a tool to reset database periodically

## tools
- laravel
- cronjob


## Steps
1. install cronjob
- run command ````apt-get update && apt-get upgrade````
- run command ````apt-get install cron````
- run command ````systemctl status cron````

2. setup project project
- run command ````git clone git@github.com:ComeBackApp/reset-database-tool.git````
- run command ````cp .env.example .env````  
- run command ````composer install````
- run command ````php artisan key:generate install````
- copy reset database script file into /home/name_of_file.sql
- configure database connection and path to reset database script (/home/name_of_file.sql) in ````.env````


4. configure laravel schedule on crontab
- nano /etc/crontab
- paste this ````* * * * * cd /path-to-your-project && php artisan schedule:run >> /dev/null 2>&1```` and change ````/path-to-your-project```` to the path of your project (usd pwd command to find the path)
