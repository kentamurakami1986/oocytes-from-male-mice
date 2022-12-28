library(QDNAseq)
library(QDNAseq.mm10)

bins <- getBinAnnotations(binSize=1000, genome="mm10")

readCounts <- binReadCounts(bins)

readCounts <- applyFilters(readCounts)

readCounts <- estimateCorrection(readCounts)

readCounts <- applyFilters(readCounts, chromosomes=NA)

copyNumbers <- correctBins(readCounts)

copyNumbersNormalized <- normalizeBins(copyNumbers)

copyNumbersSmooth <- smoothOutlierBins(copyNumbersNormalized)

plot(copyNumbersSmooth)

copyNumbersSegmented <- segmentBins(copyNumbersSmooth)

copyNumbersSegmented <- normalizeSegmentedBins(copyNumbersSegmented)

copyNumbersCalled <- callBins(copyNumbersSegmented, method = "cutoff", cutoffs = c(-0.96, 0.57))

plot(copyNumbersCalled)
