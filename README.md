# meter
Simple device power monitoring with [Twillio](https://www.twilio.com/docs/) Integration. Requires Twillio SID/Authentication. Recieve an SMS message whenever your device power falls below a specified percentage. 

## Usage
After cloning the repository, ensure .sh scripts are executable
```
chmod +x sentinel.sh alert.sh setup.sh

```
Run the `setup.sh` script
```
./setup.sh
Twillio SID: <Enter SID>
Twillio Token: <Enter Token>
Number Recieving Alerts: <Enter # w/ Format +12223334444>
```
If setup is successful this output will be printed
```
Setup Complete with <Twillio Number> alerting <Recieving Number>
```
*Note:* Twillio trial accounts with only 1 number already provisioned will need to be overridden in `.twillio_num` after setup. 

## Scheduling
Schedule `sentinel.sh` using `crontab`:
```
sudo su -
crontab -u <username> -e 
```
Enter in your crontab statement, for example:
```
*/5 * * * * sh <Absolute Path To>/sentinel.sh
```
*Note:* This schedules a device power check every 5 minutes
Test that your statement saved with:
```
crontab -u <username> -l
```

## Modifying Script
To alter the threshold power % that triggers SMS, simply change the integer in this line in `sentinel.sh`
```
if [ "$power" -lt 20 ]
```

## Versioning
Meter adheres to Semantic Versioning 2.0.0. Learn more [here](https://semver.org/).