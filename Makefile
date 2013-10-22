all:
	export PATH=/opt/gnat/bin:$PATH
	gprbuild visualiseur

home:
	gprbuild visualiseur

clean:
	gprclean
