# Configuration for dotnet build
# 

GENERIC_ARCHS = ARM7
UNSUPPORTED_ARCHS += $(PPC_ARCHES) $(ARM5_ARCHES)

DOTNET_OS = linux

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
# 	DOTNET_ROOT_X86=$(WORK_DIR)/../../../native/dotnet-sdk-x64/work-native
endif


ifeq ($(strip $(NUGET_PACKAGES)),)
	# download dependencies only once
	# https://github.com/dotnet/sdk/commit/e5a9249418f8387602ee8a26fef0f1604acf5911
	NUGET_PACKAGES=$(DISTRIB_DIR)/nuget/packages
endif

ifeq ($(strip $(DOTNET_RELEASE)),)
DOTNET_BUILD_ARGS += --configuration Release
endif
ifeq ($(strip $(DOTNET_SELF_CONTAINED)),1)
	DOTNET_BUILD_ARGS += --self-contained
endif

DOTNET_BUILD_ARGS += --runtime $(DOTNET_OS)-$(DOTNET_ARCH)

DOTNET_BUILD_ARGS += --output="$(STAGING_INSTALL_PREFIX)"


ifeq ($(strip $(DOTNET_SMALL)),1)
# PublishSingleFile better for packaging than multiple small dlls
# PublishReadyToRun improve the startup time of your .NET Core application
#   by compiling your application assemblies as ReadyToRun (R2R) format.
#   R2R is a form of ahead-of-time (AOT) compilation.
# PublishTrimmed reduce the size of apps by analyzing IL and trimming unused assemblies.
#   (not aware of reflection, needs testing, shaves ~10mb of binary)
# self-contained include .NET Runtime
	DOTNET_BUILD_ARGS += "-p:GenerateDocumentationFile=false;DebugSymbols=false;DebugType=none;UseAppHost=true;PublishSingleFile=true;PublishReadyToRun=true;PublishReadyToRunShowWarnings=true;PublishTrimmed=True"
endif

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
