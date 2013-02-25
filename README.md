# Mantle iOS Framework Builder

## About Mantle

[Mantle](https://github.com/github/Mantle) is a **great model framework** for Cocoa and Cocoa Touch.

[Mantle](https://github.com/github/Mantle) makes it easy to write a simple model layer for your Cocoa or Cocoa Touch application.

You can learn more about Mantle [here](https://github.com/github/Mantle);

## About Mantle iOS Framework Builder

Mantle iOS Framework Builder makes it super easy to use Mantle in your own project by compiling Mantle to a standard static [iOS-Framework](https://github.com/jverkoey/iOS-Framework).

It's a shell script, and super easy to use. You can just download or clone this repository to your Mac, and edit a parameter in the `Mantle-iOS-Framework-Builder.sh` file, then run `Mantle-iOS-Framework-Builder.sh`, you'll get your `Mantle.framework`.

To use Mantle in your own project, just drag the `Mantle.framework` in to the `Frameworks` group in your project. Then `#import <Mantle/Mantle.h>
`.

### Usage

1. Download or clone this repository to your Mac.

2. Run the shell script `Mantle-iOS-Framework-Builder.sh`

		cd Mantle-iOS-Framework-Builder/
		
		# for example, the Mantle project is in ~/Developer/Mantle
		
		./Mantle-iOS-Framework-Builder.sh ~/Developer/Mantle/
	
3. When `Mantle-iOS-Framework-Builder.sh` says "All Done!". You'll find a folder named `Mantle-iOS-Framework` on your Desktop. Open it, and you'll find the `Mantle.framework`.

	![](https://github.com/YuAo/Mantle-iOS-Framework-Builder/raw/master/Screenshots/Mantle-Framework-File.png)

4. Drag the `Mantle.framework` into the `Frameworks` group of your project. And `#import <Mantle/Mantle.h>` wherever you want to use Mantle.

	![](https://github.com/YuAo/Mantle-iOS-Framework-Builder/raw/master/Screenshots/Add-Mantle-Framework.png)

### Command Reference

`Mantle-iOS-Framework-Builder.sh` can take 2 parameters.

		Mantle-iOS-Framework-Builder.sh <mantle-project-directory> <output-directory>

`mantle-project-directory`: The absolute path to the directory which contains the Mantle.xcodeproj file. Default is `~/Developer/Open Source Libraries/Mantle/`

`output-directory`: The final .framework file will be generated here. Default is `~/Desktop/Mantle-iOS-Framework/`

You can change the default value by editing `Mantle-iOS-Framework-Builder.sh`

### License

Mantle iOS Framework Builder is released under the MIT license. See [LICENSE.md](https://github.com/YuAo/Mantle-iOS-Framework-Builder/blob/master/LICENSE.md).

**Copyright (c) 2013 YuAo and contributors.**
