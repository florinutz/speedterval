# speedterval

### speedtest at regular intervals

## usage
First, you'll have to install speedtest [the official way](https://www.speedtest.net/apps/cli) 
or using the unofficial ubuntu package: 
```bash
sudo apt install speedtest-cli
```

Then you can actually use the tool:
```bash
git clone https://github.com/florinutz/speedterval.git
cd speedterval
chmod +x speedterval.sh
./speedterval.sh -h
```

```
Check download speed periodically

Syntax: speedterval.sh [-c|t|l|h]
options:
  -c <int>     Specifies the number of tests that should be performed. Default infinite.
  -t <time>     Delay between tests, in the format accepted by the sleep command. Defaults to 1m.
  -l <logPath>  Path to log results to. Default /dev/null
  -h            Print usage
```

## Examples

This will perform 60 speedtests at 2 minutes apart from each other and log the results:
```bash
speedterval -c 60 -t 2m -l /var/log/speedtest.log
```
And this will run 3 tests with 1 minute in between:
```bash
speedterval -c 3
```
