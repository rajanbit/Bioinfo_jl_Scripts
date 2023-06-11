# This julia script parse fasta fila 
########################################################
# Function for parsing fasta file
function parse_fasta(fasta_file)
	header = ""
	seq = ""
	for line in eachline(fasta_file)
		if startswith(line, ">") && isequal(seq, "")
			header = strip(line)
		elseif !startswith(line, ">")
			seq *= strip(line)
		elseif startswith(line, ">") && !isequal(seq, "")
			#println(header[2:end], seq)
			seq = ""
			header = strip(line)
		end
	end
	#println(header[2:end],seq)
end
# Calling parse_fasta function
parse_fasta(ARGS[1])
########################################################
# Usage: $ julia parse_fasta.jl <seq.fasta>
