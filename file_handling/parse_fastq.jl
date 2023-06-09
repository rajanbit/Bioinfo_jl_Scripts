# This julia script parse fastq file 
########################################################
# Function for parsing fastq file
function parse_fastq(fastq_file)
	header = seq = qual = ""
	count_l = 0
	for line in eachline(fastq_file)
		if startswith(line, "@") && isequal(count_l, 0)
			header = strip(line)
			count_l = 1
		elseif	isequal(count_l, 1)
			seq = strip(line)
			count_l = 2
		elseif isequal(count_l, 2)
			count_l = 3
		else isequal(count_l, 3)
			qual = strip(line)
			count_l = 0
			#println(header,seq,"+",qual)
			header = seq = qual = ""
		end
	end
end
# Calling parse_fastq function
parse_fastq(ARGS[1])
########################################################
# Usage: julia parse_fastq.jl <sample.fastq>
