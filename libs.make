CURLPP = curlpp-0.8.1
CATCH2 = catch-2.7.2
CXXOPTS = cxxopts-2.1.2
PROCXX = procxx
CTRE = ctre-2.6.4

# Automatically find directories with headers and compiled libraries,
# as structure of libraries controls on download step.
override CXXFLAGS += $(addprefix -I,$(wildcard $(LIB)/*/include))
override LDFLAGS += $(addprefix -L,$(wildcard $(LIB)/*/lib))

override LDLIBS += -lcurl -lcurlpp -lpugixml

# First parameter — GitHub user/repo,
# second — reference,
# third — remote file path,
# fourth — output file path.
define get_header_only_lib
	@echo 'Retrieving header-only library $(1)...'
	@mkdir -p '$(dir $(4))'
	@curl -o $(4) -sL 'https://raw.githubusercontent.com/$(1)/$(2)/$(3)'
endef

# First parameter — GitHub user/repo,
# second — reference,
# third — output directory.
define get_repo
	@echo 'Downloading $(1)...'
	@rm -rf '$(3)' && mkdir -p '$(3)'
	@curl -sL 'https://api.github.com/repos/$(1)/tarball/$(2)' | \
		tar -xzC '$(3)' --strip-components=1
endef


LIBS = curlpp catch2 cxxopts procxx ctre
.PHONY: libs $(LIBS)
libs: $(LIBS)

curlpp:
	$(call get_repo,jpbarrette/curlpp,v0.8.1,$(LIB)/.$(CURLPP).tmp)

	@echo 'Building $(CURLPP)...'
	@cd '$(LIB)/.$(CURLPP).tmp' && cmake . && make curlpp_static -j$(THREADS)

	@echo 'Placing files...'
	@rm -rf '$(LIB)/$(CURLPP)' && mkdir -p '$(LIB)/$(CURLPP)/lib'
	@mv '$(LIB)/.$(CURLPP).tmp/libcurlpp.a' '$(LIB)/$(CURLPP)/lib'
	@mv '$(LIB)/.$(CURLPP).tmp/include' '$(LIB)/$(CURLPP)'
	@rm -rf '$(LIB)/.$(CURLPP).tmp'

catch2:
	$(call get_header_only_lib,catchorg/Catch2,v2.7.2,single_include/catch2/catch.hpp,$\
		$(LIB)/$(CATCH2)/include/catch2.hpp)
cxxopts:
	$(call get_header_only_lib,jarro2783/cxxopts,v2.1.2,include/cxxopts.hpp,$\
		$(LIB)/$(CXXOPTS)/include/cxxopts.hpp)
procxx:
	$(call get_header_only_lib,skystrife/procxx,master,include/process.h,$\
		$(LIB)/$(PROCXX)/include/procxx.hpp)
ctre:
	$(call get_header_only_lib,hanickadot/compile-time-regular-expressions,$\
		v2.6.4,single-header/ctre.hpp,$(LIB)/$(CTRE)/include/ctre.hpp)
