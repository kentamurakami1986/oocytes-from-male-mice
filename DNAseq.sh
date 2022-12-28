# mm10: https://jp.support.illumina.com/sequencing/sequencing_software/igenome.html
# Adapter sequence: https://support-docs.illumina.com/SHARE/AdapterSeq/Content/SHARE/AdapterSeq/Nextera/SequencesNXTILMPrepAndPCR.htm

id = file name

fastqc ${id}.fastq.gz

java -jar Trimmomatic-0.38/trimmomatic-0.38.jar SE -threads 6 -phred33 -trimlog ${id}.trimlog ${id}.fastq.gz ${id}.trim.fastq.gz ILLUMINACLIP:/Trimmomatic-0.38/adapters/NexteraFLEX-SE.fa:2:10:10 SLIDINGWINDOW:5:20 LEADING:20 TRAILING:20 CROP:50 MINLEN:50

fastqc ${id}trim.fastq.gz

bwa mem -M -R ./Mus_musculus/UCSC/mm10/Sequence/WholeGenomeFasta/genome.fa ${id}trim.fastq.gz | samtools view -@4 -bS - > ${id}.bam

samtools ${id}sort .bam -o ${id}_sorted.bam

samtools index ${id}1_sorted.bam ${id}_sorted.bai

picard MarkDuplicates AS=true REMOVE_DUPLICATES=true I=${id}_sorted.bam O=${id}_dedup_sorted.bam M=${id}.duplicate.metrics VALIDATION_STRINGENCY=LENIENT

samtools index ${id}_dedup_sorted.bam ${id}_dedup_sorted.bai
