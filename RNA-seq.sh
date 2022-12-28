id = file name

java -jar Trimmomatic-0.38/trimmomatic-0.38.jar SE -threads 8 -phred33 ${id}.fastq.gz ${id}.trim.fastq.gz ILLUMINACLIP:./Trimmomatic-0.38/adapters/NEBNext.fa:2:30:10 SLIDINGWINDOW:4:15 LEADING:20 TRAILING:20 MINLEN:30

fastqc ${id}.trim.fastq.gz

hisat2 -q -p 8 --dta -x ./RNAseq/mm10/genome -U ${id}.trim.fastq.gz | samtools sort -@8 -O BAM - > ${id}.sorted.bam

samtools index ${id}.sorted.bam

# compiling files 

featureCounts -T 8 -t exon -g gene_id -a gencode.vM24.annotation.gtf -o GVcounts.txt ${id1}sorted.bam ${id2}sorted.bam ${id3}sorted.bam ${id4}sorted.bam

cut -f 1,7- GVcounts.txt > GVcounts_selected.txt

sed -e '1d' GVcounts_selected.txt > GVcounts_filtered.txt
