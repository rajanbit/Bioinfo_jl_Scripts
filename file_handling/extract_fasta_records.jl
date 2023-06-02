### This julia script takes fasta record and accession ID files as input
### and extract records with matching accession IDs
#############################################
## Reading input files
f = readlines(ARGS[1])
a = readlines(ARGS[2])
#############################################
## Make list of accession IDs
acc_ids = []
function File2accIDsList()	
	for line in a
		global acc_ids
		append!(acc_ids, [line])
	end
	
end
#############################################
## Extract FASTA records
seq = ""
header = ""
function ExtractSeq()
	for line in f
		global seq
		global count
		global header
		global acc_ids
		if line != ""

			if line[1] == '>' && seq == ""
				header = line
			elseif line[1] != '>'
				seq *= line
			elseif line[1] == '>' && seq != ""
				for i in acc_ids
					if i == header[2:end]
						println(header*"\n"*seq)
					end
				end
				seq = ""
				header = line
			end
		end
	end	
end
#############################################
## Executing functions
File2accIDsList()
ExtractSeq()
#############################################
## Usage: $ julia extract_fasta_records.jl in.fasta ids.txt > out.fasta
