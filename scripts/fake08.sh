#!/bin/bash

##################################################################
# Created by Christian Haitian for use to easily update          #
# various standalone emulators, libretro cores, and other        #
# various programs for the RK3326 platform for various Linux     #
# based distributions.                                           #
# See the LICENSE.md file at the top-level directory of this     #
# repository.                                                    #
##################################################################

cur_wd="$PWD"
bitness="$(getconf LONG_BIT)"

	# fake08 Standalone build
	if [[ "$var" == "fake08" || "$var" == "all" ]] && [[ "$bitness" == "64" ]]; then
	 cd $cur_wd

	  # Now we'll start the clone and build of fake08
	  if [ ! -d "fake-08/" ]; then
		git clone --recursive https://github.com/jtothebell/fake-08.git

		if [[ $? != "0" ]]; then
		  echo " "
		  echo "There was an error while cloning the fake08 standalone git.  Is Internet active or did the git location change?  Stopping here."
		  exit 1
		fi
		cp patches/fake08-patch* fake-08/.
	  else
		echo " "
		echo "A fake-08 subfolder already exists.  Stopping here to not impact anything in the folder that may be needed.  If not needed, please remove the fake-08 folder and rerun this script."
		echo " "
		exit 1
	  fi

	 cd fake-08

	 fake08_patches=$(find *.patch)

	 if [[ ! -z "$fake08_patches" ]]; then
	  for patching in fake08-patch*
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

           make -C platform/libretro clean
           make -C platform/libretro -j$(nproc)
           if [[ $? != "0" ]]; then
		     echo " "
		     echo "There was an error that occured while making the fake08 standalone.  Stopping here."
             exit 1
           fi
           strip platform/libretro/fake08_libretro.so

	       if [ ! -d "../cores64/" ]; then
		     mkdir -v ../cores64
	       fi

	       cp platform/libretro/fake08_libretro.so ../cores64/.

	       gitcommit=$(git log | grep -m 1 commit | cut -c -14 | cut -c 8-)
	       echo $gitcommit > ../cores$(getconf LONG_BIT)/fake08_libretro.so.commit

	       echo " "
	       echo "The fake08 executable has been created and has been placed in the rk3326_core_builds/cores64 subfolder"

	fi
