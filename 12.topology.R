


library(ape)

topology <- list()
gene.trees <- read.tree("out_1to1_five_cyathophora_70_root_clock.tre")

for (gene.tree in gene.trees) {
	
	gene.tree <- root(gene.tree, "AMA", resolve.root=TRUE)
	gene.tree <- ladderize(gene.tree, right=TRUE)
	
	newick <- write.tree(gene.tree)
	
	if (length(topology) == 0) {
		
		topology[[newick]][["tre"]] <- gene.tree
		topology[[newick]][["num"]] <- 1
	
	} else {
		
		j <- 0
		for (tree in names(topology)) {
			
			if (all.equal.phylo(gene.tree, topology[[tree]][["tre"]], use.edge.length=FALSE)) {
				topology[[tree]][["num"]] <- topology[[tree]][["num"]] + 1
				
				j <- 1
				break
			}
		}
		
		if (j == 0) {
			
			topology[[newick]][["tre"]] <- gene.tree
			topology[[newick]][["num"]] <- 1
		}
	}
}


topology <- topology[order(sapply(topology, function(x) x[["num"]]), decreasing=TRUE)]

for (tree in names(topology)) {
	cat(tree, topology[[tree]][["num"]], sep="   ", fill=TRUE)
}


