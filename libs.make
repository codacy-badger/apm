CATCH2 = catch-2.7.2
CXXOPTS = cxxopts-2.1.2

# Automatically find directories with headers and compiled libraries,
# as structure of libraries controls on download step.
override CXXFLAGS += $(addprefix -I,$(wildcard $(LIB)/*/include))
override LDFLAGS += $(addprefix -L,$(wildcard $(LIB)/*/lib))

override LDLIBS += -lcurl -lcurlpp -lpugixml -ltiny-process-library

# First parameter — GitHub user/repo,
# second — reference,
# third — remote file path,
# fourth — output file path.
define get_header_only_lib
	$(info Retrieving header-only library $(1)...)
	@$(UNIX_PREFIX)mkdir -p '$(dir $(4))'
	@$(UNIX_PREFIX)curl -o $(4) -sL 'https://raw.githubusercontent.com/$(1)/$(2)/$(3)'
endef

LIBS = catch2 cxxopts
.PHONY: libs $(LIBS)
libs: $(LIBS)

catch2:
	$(call get_header_only_lib,catchorg/Catch2,v2.7.2,single_include/catch2/catch.hpp,$\
		$(LIB)/$(CATCH2)/include/catch2.hpp)
cxxopts:
	$(call get_header_only_lib,jarro2783/cxxopts,v2.1.2,include/cxxopts.hpp,$\
		$(LIB)/$(CXXOPTS)/include/cxxopts.hpp)
