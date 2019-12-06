comp : 
	vcs -full64 tb_pra.sv -y ../aes/src +libext+.v -sverilog +timescale=1ns/1ps

clean :
	rm csrc simv* ucli.key -rf

sim : 
	./simv

all : clean comp sim