#!/bin/bash

# Author: Aksel Kristiansen Borgmo
# General shell script for automation of scenario executions on Solstorm Cluster

projectDir="${PWD}"
Nodes=("$@")
N=${#Nodes[@]}
Scenarios=(1 2 3 4)
M=${#Scenarios[@]}
Threading="false"
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
