# Flappy Bird with AI
This application is based on the clasic Flappy Bird game. This game was built with HaxeFlixel.

It has a new feature compared to the classic game, I added an AI mode where the bird plays without user intervenction and never lose. I used artificial neural nets without libraries to model the AI.

# Requierements
- Install Haxel, to download go to https://haxe.org/download/.
- Install HaxeFlixel and dependencies, please follows this doc https://haxeflixel.com/documentation/install-haxeflixel/.
```sh
# the docs shoud say something like this

haxelib install lime
haxelib install openfl
haxelib install flixel

haxelib run lime setup flixel
haxelib run lime setup

haxelib install flixel-tools
haxelib run flixel-tools setup
```
Note: this can work on Mac M1 as well.

# How to run
```sh
# you have several options, a few of them (but some of them requires more configurations to do)
lime run html5
lime run macos
lime run android
lime run ios
lime test ios
```

# How to build
```sh
lime build html5
```

# Build .ipa files for iOS
First step is build the ios app
```sh
lime build ios
```
Building .ipa file
1. Create a folder called Payload
2. Place the .app folder inside of that
3. Zip up the Payload folder using normal compression
4. Then rename the file with a .ipa extension

Source: https://gist.github.com/bananita/8039021
