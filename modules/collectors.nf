process COLLECT_FQs {
	tag "Collecting Fastq on $sample.name using $task.cpus CPUs $task.memory"
	label "s_cpu"
	label "s_mem"

	input:
	val sample

	output:
	tuple val(sample.name), path("basecalled/pass/*.gz")

	when:
	sample.type == 'fastq'

	script:
	"""
	echo Collecting fastqs for $sample.name
	mkdir -p basecalled/pass/
	find ${sample.path} -type f -name '*.fastq.gz' | xargs -I % rsync --progress % ./basecalled/pass/
	"""
} 

process COLLECT_BAMs {
	tag "Collecting bam on $sample.name using $task.cpus CPUs $task.memory"
	label "s_cpu"
	label "s_mem"
	
	input:
	tuple val(name), val(sample)

	output:
	tuple val(sample.name), val(sample), path("${sample.name}.remapped.sorted.bam"), path("${sample.name}.remapped.sorted.bam.bai")
	
	when:
	sample.type == 'bam'

	script:
	"""
	echo Collecting bams for $sample.name
	find ${sample.path} -type f -name "${sample.name}.remapped.sorted.ba*" | xargs -I % rsync --progress % .
	"""
} 