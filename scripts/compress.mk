%.gz: %
	@gzip -v -c -9 < $< > $@
%.xz: %
	@xz -v --check=crc32 -9 < $< > $@
%.zst: %
	@zstd -v -T0 < $< > $@
%.lz4: %
	@lz4 -l < $< > $@
%.lzo: %
	@lzop -9 -v < $< > $@
%.bz2: %
	@bzip2 -v -c -9 < $< > $@
%.lzma: %
	@lzma -v -c -9 < $< > $@
