#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export PATH

die() {
    echo -e "$@"
    exit 1
}

mkdir -p /home/ec2-user/.ssh || die "ERROR: Unable to create the /home/ec2-user/.ssh directory."
touch /home/ec2-user/.ssh/authorized_keys || die "ERROR: Unable to create the /home/ec2-user/.ssh/authorized_keys file."
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDaYHHk/n9cv1pi/J34FowOM13JsYddYnsaaL8DFT1kavKOEYZqYvNkxTjZLHaLquWtigmrl3P1kONG874HcZyR/M4VnPsyig9giKb0qhJc5sLnboji4po755zvJlg1jHraQq/UN7e2G0GYU7OdBq0DhZOthOYiB6Io8oemBk5aqeNvw03I6iSW7FLAJPxr0e8TeOcH8IIELo+XVjHXL7zulVXs34TpUVwaVwOW4ClLeDb4MDo2JPnrLw+CxudvBFiGlcrk6hheKboLQppM0OIVDPCgmBZs9V1kflBMZ+gSjKFIX1CF0XjXqnXglyVyf4Rb9Ky7xkO4m6jP22Aj5TA1 ec2-user@ip-172-19-0-18.us-east-2.compute.internal' | tee -a /home/ec2-user/.ssh/authorized_keys || die "Error: Unable to write the SSH Public Key of the ec-user user."

chown -R ec2-user:ec2-user /home/ec2-user/.ssh || die "ERROR: unable to change ownership."
chmod 0700 /home/ec2-user/.ssh || die "ERROR: unable to change permission."
chmod 0600 /home/ec2-user/.ssh/authorized_keys || die "ERROR: unable to change permission of the file."

echo "Success: the userdata.sh script has been executed successfully." | tee -a /var/log/messages
