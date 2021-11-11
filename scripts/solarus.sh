#!/bin/bash
cur_wd="$PWD"
bitness="$(getconf LONG_BIT)"

	# Solarus Standalone build
	if [[ "$var" == "solarus" ]] && [[ "$bitness" == "64" ]]; then
	 cd $cur_wd

	  # Now we'll start the clone and build of solarus
	  if [ ! -d "solarus/" ]; then
		git clone --recursive https://gitlab.com/solarus-games/solarus.git -b release-1.6.5

		if [[ $? != "0" ]]; then
		  echo " "
		  echo "There was an error while cloning the solarus standalone git.  Is Internet active or did the git location change?  Stopping here."
		  exit 1
		fi
		cp patches/solarus-patch* solarus/.
	  else
		echo " "
		echo "A solarus subfolder already exists.  Stopping here to not impact anything in the folder that may be needed.  If not needed, please remove the solarus folder and rerun this script."
		echo " "
		exit 1
	  fi

	 # Ensure dependencies are installed and available
	 apt-get update
	 apt-get -y install build-essential cmake pkg-config libsdl2-dev libsdl2-image-dev libsdl2-ttf-dev libluajit-5.1-dev libphysfs-dev libopenal-dev libvorbis-dev libmodplug-dev qtbase5-dev qttools5-dev qttools5-dev-tools libglm-dev
	 if [[ $? != "0" ]]; then
	   echo " "
	   echo "There was an error while installing the necessary dependencies.  Is Internet active?  Stopping here."
	   exit 1
	 fi

	 cd solarus
	 
	 solarus_patches=$(find *.patch)
	 
	 if [[ ! -z "$solarus_patches" ]]; then
	  for patching in solarus-patch*
	  do
		   patch -Np1 < "$patching"
		   if [[ $? != "0" ]]; then
			echo " "
			echo "There was an error while applying $patching.  Stopping here."
			exit 1
		   fi
		   rm "$patching" 
	  done
	 fi

	  mkdir build
	  cd build
	  cmake -DSOLARUS_GL_ES=ON -DSOLARUS_GUI=OFF -DSOLARUS_USE_LUAJIT=ON -DSOLARUS_TESTS=OFF ..
	  make -j$(nproc)

	  if [[ $? != "0" ]]; then
		echo " "
		echo "There was an error while building the newest solarus standalone.  Stopping here."
		exit 1
	  fi

	  strip solarus-run
	  strip libsolarus.so.1.*

	  if [ ! -d "../../solarus$bitness/" ]; then
		mkdir -v ../../solarus$bitness
	  fi

	  cp solarus-run ../../solarus$bitness/.
	  cp libsolarus.so.* ../../solarus$bitness/.
	  
	  echo " "
	  echo "solarus-run executable and related files have been created and has been placed in the rk3326_core_builds/solarus$bitness subfolder"

	fi
