#!/bin/bash
v=`date +%Y-%m-%d-%H-%M-%S`
script="cd /var/www/html/; mv nozomi_german.zip nozomi_german.zip-$v; mv nozomi_german.version nozomi_german.version-$v"
ssh New  "$script"
scp test.zip New:/var/www/html/nozomi_german.zip
scp version New:/var/www/html/nozomi_german.version
