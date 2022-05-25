#!/bin/bash

# Author: Aksel Kristiansen Borgmo
# General shell script for automation of scenario executions on Solstorm Cluster


# Parameters to set by the user:
Scenarios=(1 2 3 4)
Threading="false"

#Fixed code:
projectDir="${PWD}"
Nodes=("$@")
N=${#Nodes[@]}
M=${#Scenarios[@]}
s=$(( $M / $N ))

for (( i=0; i<$N; i++ ))
do
	if [ $i != $(( $N - 1)) ]
	then
		echo "Node "$i" is computing scenarios "${Scenarios[@]::s}
		screen -d -m -S node$i ssh "compute-"${Nodes[$i]} $projectDir/slave.bash $projectDir ${Scenarios[@]::s} $Threading
		Scenarios=(${Scenarios[@]: s})
		echo "Remaining scenarios: "${Scenarios[@]}
	else
		echo "Node "$i" is computing scenarios "${Scenarios[@]}
		screen -d -m -S node$i ssh "compute-"${Nodes[$i]} $projectDir/slave.bash $projectDir ${Scenarios[@]} $Threading
	fi
done
