Assumptions
1. Cron expression 2.30 AM each sunday
2. Remote folder = /home/user/remotefolder
3. Incremental backup with rsync command
4. user-key-pair.pem consider private and public key already correctly installed and configured

Notes
For example, I use cron expressions on Amazon cloudwatch Events to configure EC2 start and stop for 
staging environments by calling lambda functions that perform the task.
