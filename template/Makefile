# new and improved pico makefile.
t1=pico game
t2=by alan morgan
res=res.p8

.PHONY: all clean
all: out.p8

# target, code files
# below, thanks to:
# https://serverfault.com/questions/172284/linux-cat-with-separators-among-files
compile_code = head --lines=3 $(res) > $(1); \
					/bin/echo "-- $(t1)" >> $(1); \
					/bin/echo "-- $(t2)" >> $(1); \
					awk 'FNR==1 && NR!=1 {print "------ " FILENAME}{print}' $(2) >> $(1); \
					tail --lines=+5 $(res) >> $(1);

files=$(shell find -path './src/*.lua' | grep -v '/demo')
out%p8: src/demo%lua $(files) $(res)
	$(call compile_code,$@,$< $(files))

clean:
	find . -maxdepth 1 -name 'out*.p8' -delete;
