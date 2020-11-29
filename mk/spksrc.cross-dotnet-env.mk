# Configuration for dotnet build
# 

# NOTE: 32bit (x86) is not supported:
# https://github.com/dotnet/core/issues/5403
# https://github.com/dotnet/core/issues/4595
GENERIC_ARCHS = ARM7
UNSUPPORTED_ARCHS += $(PPC_ARCHES) $(ARM5_ARCHES) $(x86_ARCHES)

DOTNET_OS = linux


ifeq ($(strip $(FRAMEWORK)),)
	FRAMEWORK=netcoreapp3.1
endif
DOTNET_BUILD_ARGS += -f $(FRAMEWORK)

# Define DOTNET_ARCH for compiler
ifeq ($(findstring $(ARCH),$(ARM7_ARCHES)),$(ARCH))
	DOTNET_ARCH = arm
endif
ifeq ($(findstring $(ARCH),$(ARM8_ARCHES)),$(ARCH))
	DOTNET_ARCH = arm64
endif
ifeq ($(findstring $(ARCH),$(x86_ARCHES)),$(ARCH))
	DOTNET_ARCH = x86
endif
ifeq ($(findstring $(ARCH),$(x64_ARCHES)),$(ARCH))
	DOTNET_ARCH = x64
endif
ifeq ($(DOTNET_ARCH),)
	# don't report error to use regular UNSUPPORTED_ARCHS logging
	$(warning Unsupported ARCH $(ARCH))
endif

ifeq ($(strip $(DOTNET_ROOT)),)
	# dotnet sdk
	DOTNET_ROOT=$(WORK_DIR)/../../../native/dotnet-sdk/work-native
endif

ifeq ($(strip $(DOTNET_ROOT_X86)),)
	# dotnet sdk-32bit
	DOTNET_ROOT_X86=""
# 	DOTNET_ROOT_X86=$(WORK_DIR)/../../../native/dotnet-x86-sdk/work-native
endif


ifeq ($(strip $(NUGET_PACKAGES)),)
	# download dependencies only once
	# https://github.com/dotnet/sdk/commit/e5a9249418f8387602ee8a26fef0f1604acf5911
	NUGET_PACKAGES=$(DISTRIB_DIR)/nuget/packages
endif

# ifeq ($(strip $(DOTNET_NOT_RELEASE)),)
	DOTNET_BUILD_ARGS += --configuration Release
# endif
ifdef ($(strip $(DOTNET_SELF_CONTAINED)),1)
	# https://docs.microsoft.com/en-us/dotnet/core/deploying/#publish-self-contained
	DOTNET_BUILD_ARGS += --self-contained
endif

ifdef ($(strip $(DOTNET_SINGEL_FILE)),1)
	DOTNET_BUILD_PROPERTIES += "-p:PublishSingleFile=true"
endif

DOTNET_BUILD_ARGS += --runtime $(DOTNET_OS)-$(DOTNET_ARCH)

DOTNET_BUILD_ARGS += --output="$(STAGING_INSTALL_PREFIX)/$(DOTNET_OUTPUT_PATH)"

ifeq ($(strip $(DOTNET_SMALL)),1)
# PublishSingleFile better for packaging than multiple small dlls
# PublishReadyToRun improve the startup time of your .NET Core application
#   by compiling your application assemblies as ReadyToRun (R2R) format.
#   R2R is a form of ahead-of-time (AOT) compilation.
# PublishTrimmed reduce the size of apps by analyzing IL and trimming unused assemblies.
#   (not aware of reflection, needs testing, shaves ~10mb of binary)
# self-contained include .NET Runtime
	DOTNET_BUILD_PROPERTIES += "-p:UseAppHost=true;PublishReadyToRun=true;PublishReadyToRunShowWarnings=true"
endif

DOTNET_BUILD_ARGS += $(DOTNET_BUILD_PROPERTIES)

# https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet#environment-variables
# https://github.com/dotnet/docs/blob/master/docs/core/tools/dotnet.md#environment-variables
# https://github.com/dotnet/sdk/commit/e5a9249418f8387602ee8a26fef0f1604acf5911
# https://github.com/dotnet/docs/pull/21303
ENV += DOTNET_PACKAGE_NAME=$(DOTNET_PACKAGE_NAME)
ENV += DOTNET_ROOT=$(DOTNET_ROOT)
ENV += DOTNET_ROOT\(x86\)=$(DOTNET_ROOT_X86)
ENV += NUGET_PACKAGES=$(NUGET_PACKAGES)
ENV += PATH=$(DOTNET_ROOT)/:$$PATH
ENV += DOTNET_ARCH=$(DOTNET_ARCH)
ENV += DOTNET_OS=$(DOTNET_OS)
ENV += DOTNET_CLI_TELEMETRY_OPTOUT=1
