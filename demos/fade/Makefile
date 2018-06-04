t1=pico game
t2=by alan morgan
res=res.p8
files=$(shell find -path '*src/*.p8' | grep -v '/dem_')

.PHONY: all clean
all: out.p8
clean:
	find . -maxdepth 1 -name 'out*.p8' -delete;

# target, code files
# below, thanks to:
# https://serverfault.com/questions/172284/linux-cat-with-separators-among-files
compile_code = head --lines=3 $(res) > $(1); \
					/bin/echo "-- $(t1)" >> $(1); \
					/bin/echo "-- $(t2)" >> $(1); \
					awk 'FNR==1 && NR!=1 {print "-->8"}{print}' $(2) >> $(1); \
					tail --lines=+5 $(res) >> $(1);

out%: src/demo% $(files) $(res)
	$(call compile_code,$@,$^ $(files))
