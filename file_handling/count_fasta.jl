### This julia script takes fasta file as input
### and count number of fasta records
##################################################
count = 0
for line in eachline(ARGS[1])
	global count	
	if startswith(line, ">")
		count=count+1

	end
end
println(count, " records found")
##################################################
## Usage: $ julia count_fasta.jl <seq.fasta>
