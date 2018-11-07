# modified makefile (for modules)
t1=mod test
t2=by alan morgan
res=res.p8

.PHONY: all clean
all: out_tbox.p8 out_logo.p8 out_tl.p8 out_col.p8 out_att.p8 out_tcol.p8 out_view.p8

# target, code files
# below, thanks to:
# https://serverfault.com/questions/172284/linux-cat-with-separators-among-files
compile_code = head --lines=3 $(res) > $(1); \
					/bin/echo "-- $(t1)" >> $(1); \
					/bin/echo "-- $(t2)" >> $(1); \
					awk 'FNR==1 && NR!=1 {print "-->8"}{print}' $(2) >> $(1); \
					tail --lines=+5 $(res) >> $(1);

out_%.p8: dem_%.lua mod_%.lua
	$(call compile_code,$@,$^)

clean:
	find . -maxdepth 1 -name 'out*.p8' -delete;

