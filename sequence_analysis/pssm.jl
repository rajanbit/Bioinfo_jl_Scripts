# This script takes aligned sequences in FASTA format as input
# and generate a PSSM profile
###################################################################
# Function 1: Creating array from fasta records
function fasta2array(fasta_file)
	arr = []
	header = ""
	seq = ""
	for line in eachline(fasta_file)
		if startswith(line, ">") && isequal(seq, "")
			header = strip(line)
		elseif !startswith(line, ">")
			seq *= strip(line)
		elseif startswith(line, ">") && !isequal(seq, "")
			arr = [arr; [collect.(seq)]]
			seq = ""
			header = strip(line)
		end
	end
	arr = [arr; [collect.(seq)]]
	return arr
end
###################################################################
# Function 2: Array to frequency matrix
function array2freq(seq_array)
	freq_arr = []
	for i = 1:length(seq_array[1])
		col_arr = []
		for j = 1:length(seq_array)
			push!(col_arr, seq_array[j][i])
		end
		count_arr = []
		for nt in ['A', 'T', 'G', 'C']
			if !isequal(count(i->(i == nt), col_arr), 0)
				push!(count_arr, count(i->(i == nt), col_arr))
			elseif isequal(count(i->(i == nt), col_arr), 0)
				push!(count_arr, 0)
			end
		end
		freq_arr = [freq_arr; [count_arr/length(seq_array)]]	
	end
	matrix = hcat(freq_arr)
	return matrix
end
###################################################################
# Function 3: Normalizing frequency matrix
function normalize(matrix)
	arr = []
	for i = 1:length(matrix[1])
		temp = []
		for j = 1:length(matrix)
			push!(temp, matrix[j][i])
		end
		arr = [arr; [temp/((sum(temp))/(length(temp)))]]
	end	
	return arr
end
###################################################################
# Function 4: Log2 transformation of normalized matrix
function log2transform(matrix)
	arr = []
	for i in matrix
		temp = []
		for j in i
			push!(temp, log2(j))
		end
		arr = [arr; [round.(temp; digits=2)]]
	end
	return hcat(arr)
end
###################################################################
# Create PSSM
seq_array = fasta2array(ARGS[1])
freqMat = array2freq(seq_array)
n_matrix = normalize(freqMat)
score = log2transform(n_matrix)
println(score)
###################################################################
# Usage: $ julia pssm.jl <aln.fasta>
