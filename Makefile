
ps2: ps2.ice
	silice-make.py -s ps2.ice -b ulx3s -p basic,gpio,us2_ps2 -o BUILD_$(subst :,_,$@)

led_glow: led_glow.ice
	silice-make.py -s led_glow.ice -b ulx3s -p basic -o BUILD_$(subst :,_,$@)

clean:
	rm -rf BUILD_*
