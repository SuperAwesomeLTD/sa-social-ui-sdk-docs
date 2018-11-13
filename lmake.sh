#!/bin/bash -ex

# Step 1: get env variables from the buildata JSON
if [ -f buildata.json ]
then
	sdk_theme_folder=$(cat buildata.json | jq -r '.theme.folder')
	sdk_themeres_folder=$(cat buildata.json | jq -r '.theme.res')
	sdk_theme=$(cat buildata.json | jq -r '.theme.name')
	sdk_color=$(cat buildata.json | jq -r '.theme.color')
	sdk_project=$(cat buildata.json | jq -r '.project.name')
	sdk_domain=$(cat buildata.json | jq -r '.project.domain')
	sdk_author=$(cat buildata.json | jq -r '.project.author')
	sdk_min=$(cat buildata.json | jq -r '.project.min')
	sdk_id=$(cat buildata.json | jq -r '.id')
	sdk_source=$(cat buildata.json | jq -r '.project.source')
	sdk_support=$(cat buildata.json | jq -r '.company.support')
	sdk_company=$(cat buildata.json | jq -r '.company.name')
	sdk_current_version="0.0.0"

	if [ -d versions ]
	then

		# Step 2: create a build/html folder needed by deploy.sh
		if [ -d build ]
		then
			rm -rf build
		fi
		mkdir build
		mkdir build/html/

		# Step 3: goto main versions folder
		cd versions

		# Step 4: get the most current version based
		# on version "size" (e.g. 5.2.4=524 > 5.1.0=510)
		max=0
		for version in *; do
			dotArray=(${version//./ })
			len=$((${#dotArray[@]}-1))
			SUM=0;
			for i in ${dotArray[@]};
			do
				pow=$((100**$len))
				SUM=$(($SUM + $i*$pow));
				len=$(($len-1))
		  done;
			echo $SUM

			# check the max version and change sdk_current_version
			if [ $SUM -gt $max ]
			then
				max=$SUM
				sdk_current_version=$version
			fi
		done

		# Step 5: get the full version string (needed for sphinx)
		version_string=""
		for version in *; do
			if [ -d $version ]
			then
				if [ $version = $sdk_current_version ]
				then
					version_string+="{'name':u'$version', 'folder':u'latest'}, "
				else
					version_string+="{'name':u'$version', 'folder':u'$version'}, "
				fi
				echo $version_string > out.dat;
			fi
		done

		full_version_string=$(cat out.dat)
		full_version_string="[ $full_version_string ]"
		rm out.dat
		echo $full_version_string

		# Step 6: now correctly build all documentations
		for version in *; do
			if [ -d $version ]
			then
				# goto version folder
				cd $version

				# goto source folder
				cd source

				# download latest theme
				rm -rf $sdk_theme_folder
				rm -rf $sdk_themeres_folder
				rm -rf sa-docs-sphinx-theme
				git clone -b master https://github.com/SuperAwesomeLTD/sa-docs-sphinx-theme.git
				mkdir $sdk_theme_folder
				mkdir $sdk_theme_folder/$sdk_theme
				mkdir $sdk_themeres_folder
				cp -rf sa-docs-sphinx-theme/* $sdk_theme_folder/$sdk_theme/

				cd $sdk_theme_folder/$sdk_theme/static/css

				sed -i.sedbak "s|background-color: #c32e21;|background-color: #$sdk_color;|g" *.*
				find . -name "*.*sedbak" -print0 | xargs -0 rm

				cd ../../../..

				cp sa-docs-sphinx-theme/static/img/* $sdk_themeres_folder/
				cp $sdk_themeres_folder/aa_logo.png $sdk_themeres_folder/logo.png
				rm -rf sa-docs-sphinx-theme
				cd ../

				# create temporary source folder
				rm -rf rsource
				mkdir rsource

				# copy all the source there
				cp -rf source/* rsource

				# replace variables in rsource
				cd rsource
				sed -i.sedbak "s|<sdk_company>|$sdk_company|g" *.*
				sed -i.sedbak "s|<sdk_project>|$sdk_project|g" *.*
				sed -i.sedbak "s|<sdk_author>|$sdk_author|g" *.*
				sed -i.sedbak "s|<sdk_domain>|$sdk_domain|g" *.*
				sed -i.sedbak "s|<sdk_source>|$sdk_source|g" *.*
				sed -i.sedbak "s|<sdk_id>|$sdk_id|g" *.*
				sed -i.sedbak "s|<sdk_version>|$version|g" *.*
				sed -i.sedbak "s|<full_version_string>|$full_version_string|g" *.*
				sed -i.sedbak "s|<sdk_theme_folder>|$sdk_theme_folder|g" *.*
				sed -i.sedbak "s|<sdk_devsuspport>|$sdk_support|g" *.*
				sed -i.sedbak "s|<sdk_min>|$sdk_min|g" *.*
				sed -i.sedbak "s|<sdk_themeres_folder>|$sdk_themeres_folder|g" *.*
				sed -i.sedbak "s|<sdk_theme>|$sdk_theme|g" *.*
				find . -name "*.*sedbak" -print0 | xargs -0 rm
				cd ..

				# make the build
				make -f Makefile html

				# clear
				rm -rf rsource

				# go back
				cd ..

				# Step 7: copy the build HTML results into the necessary folders
				if [ $version = $sdk_current_version ]
				then
					mkdir ../build/html/latest
					cp -rf $version/build/html/* ../build/html/latest
					rm -rf $version/build
				else
					mkdir ../build/html/$version
					cp -rf $version/build/html/* ../build/html/$version
					rm -rf $version/build
				fi
			fi
		done

		cd ../

	else
		echo "To build the documentation have all your version folders (1.0.3, 1.5.2) in a central 'versions' folder."
	fi
else
	echo "To build the documentation you must have a buildata.json file present"
fi
