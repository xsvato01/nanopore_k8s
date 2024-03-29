#!/bin/bash
# Download the CSV file from a URL
wget "https://docs.google.com/spreadsheets/d/1Rlglf6H8WmyEVRrKaOvDd5cHeYJaw-qqBEs8PMnaYQc/export?format=csv" -O "samplesheet.csv"
current_dir=$(pwd)

# Convert the CSV file to JSON using a Python script
python $current_dir/project/xsvato01/nanopore_k8s/bin/CsvToJson.py $current_dir/samplesheet.csv $current_dir/samplesheet.json
