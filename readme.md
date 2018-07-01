# Introduction 

This is following Build 2018 session on [Kubenetes Best Practice](https://channel9.msdn.com/events/Build/2018/BRK3701?term=kubernetes&lang-en=true)

## setup windows environment
``` ps
.\setup.ps1
```

## setup mac environment 
``` bash
./setup.sh
```

I am working on macOS Mojave (10.14 beta) and had the following errors:

### Your XCode (9.4.1) is too outdated on beta macOS Mojave
1. need to download and install [xcode 10 beta 2](https://download.developer.apple.com/Developer_Tools/Xcode_10_Beta_2/Xcode_10_Beta_2.xip)
2. download and install [command line tool 10 beta 2](https://download.developer.apple.com/Developer_Tools/Command_Line_Tools_macOS_10.14_for_Xcode_10_Beta_2/Command_Line_Tools_macOS_10.14_for_Xcode_10_Beta_2.dmg)
3. delete xcode.app from folder 'application'
4. run `sudo xcode-select -switch /Applications/Xcode-beta.app/`
5. run `xcode-select --install`

### Permission denied @ dir_s_mkdir
run the following
```bash
manually install [python 3.7](https://www.python.org/downloads/)
```

## GCP vs. Azure
1. GCP is cheaper, faster (a few min), but UI/tooling lag behind
2. AKS is super slow to create/scale (10-30 min)