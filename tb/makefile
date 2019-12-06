comp : 
	vcs -full64 tb_aes.sv -y ../src +libext+.v -sverilog +timescale=1ns/1ps

clean :
	rm csrc simv* ucli.key -rf

sim : 
	./simv

all : clean comp sim