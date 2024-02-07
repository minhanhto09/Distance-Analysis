all: hw4.html

hw4.html: hw4.qmd data/dennys.rds data/lq.rds
	quarto render hw4.qmd

data/dennys.rds: parse_dennys.R data/dennys/*.html
	Rscript parse_dennys.R

data/lq.rds: parse_lq.R data/lq/*.html
	Rscript parse_lq.R

data/dennys/*.html: get_dennys.R
	Rscript get_dennys.R

data/lq/*.html: get_lq.R
	Rscript get_lq.R

clean:
	rm -f hw4.html
	rm -rf data/

.PHONY: clean all
