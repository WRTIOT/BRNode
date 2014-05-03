###############################################################################
#
# MODULE:   Makefile
#
# DESCRIPTION: Makefile for the Border Router Node
# 
###############################################################################
#
# This software is owned by NXP B.V. and/or its supplier and is protected
# under applicable copyright laws. All rights are reserved. We grant You,
# and any third parties, a license to use this software solely and
# exclusively on NXP products [NXP Microcontrollers such as JN5148, JN5142, JN5139]. 
# You, and any third parties must reproduce the copyright and warranty notice
# and any other legend of ownership on each copy or partial copy of the 
# software.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#
# Copyright NXP B.V. 2012. All rights reserved
#
###############################################################################
# Subversion variables
# $HeadURL: $
# $Revision: $
# $LastChangedBy: $
# $LastChangedDate: $
# $Id: $ 
#
###############################################################################

# Application target name

TARGET = BR_WirelessFirmware

###############################################################################
# VERSION_MAJOR and VERSION_MINOR should be one character
# VERSION_BUILD should be 2 characters.
# These are concatanated to make the 16 bit hexadecimal revision number.
VERSION_MAJOR    = 1
VERSION_MINOR 	 = 8
VERSION_BUILD	 = 02


###############################################################################
# User definable make parameters that may be overwritten from the command line

# Baud rate that should be used to communicate with the host processor.

HOST_BAUD_RATE ?= 1000000

###############################################################################
# Default target device is the JN5148

JENNIC_CHIP ?= JN5168

###############################################################################
# Default DK2 development kit target hardware

JENNIC_PCB ?= DEVKIT2

###############################################################################
# Define TRACE to use with DBG module
TRACE ?= 1
# Define to print debug messages from UART1
UART_DEBUG ?= 0
# Define to print debug messages from UART0
UART0_DEBUG ?= 0

ifeq ($(TRACE), 1)
CFLAGS  += -DDBG_ENABLE
endif

ifeq ($(UART_DEBUG), 1)
CFLAGS += -DUART_DEBUG
endif

ifeq ($(UART0_DEBUG), 1)
CFLAGS += -DUART_DEBUG
CFLAGS += -DHOST_UART=1
endif

# Flags to enable debug of modules

#CFLAGS += -DDBG_VERBOSE
#CFLAGS += -DDEBUG_UART_DRIVER
#CFLAGS += -DDEBUG_SERIAL_LINK
CFLAGS += -DDEBUG_BORDER_ROUTER
#CFLAGS += -DDEBUG_BORDER_ROUTER_COMMS
CFLAGS += -DDEBUG_EXCEPTIONS

###############################################################################
# Define NWK_TEST_MIB to add network test Mib
NWK_TEST_MIB ?= 0

ifeq ($(NWK_TEST_MIB), 1)
CFLAGS += -DNWK_TEST_MIB
CFLAGS += -DDBG_MIB_NWK_TEST=TRUE
endif

###############################################################################
# Optional border router functionality can be enabled/diabled by editing these flags

# Enable periodic gateway announcements - required to collect stand alone devices
CFLAGS += -DENABLE_GATEWAY_ANNOUNCEMENTS
# The period of gateway announcements may be changed here, in units of 10ms
#CFLAGS += -DGATEWAY_ANNOUNCE_INTERVAL=3000

# Enable to persist security infomation - required to communicate in a secured network
CFLAGS += -DENABLE_PERSISTENT_SECURITY_INFO

# Allow the host to set up an LED to toggle with border router activity
CFLAGS += -DENABLE_ACTIVITY_LED

# Allow selection of baud rates that are not fractions of 16MHz.
CFLAGS += -DENABLE_ADVANCED_BAUD_SELECTION

# Enable OND
CFLAGS += -DENABLE_OND

# Enable single child test mode for creating a long, thin network
#CFLAGS += -DENABLE_TEST_SINGLE_CHILD
#BIN_SUFFIX = $(HOST_BAUD_RATE)_SingleChild

# Enable RF test modes - do not enable unless you know what you're doing.
#CFLAGS += -DENABLE_TEST_MODES
#CFLAGS += -DTEST_MODE=E_TESTMODE_CW


###############################################################################
# Other build options
CFLAGS += -DGATEWAY_DEVICE_ID=$(DEV_TYPE)
CFLAGS += -DHOST_BAUD_RATE=$(HOST_BAUD_RATE)
BIN_SUFFIX := $(HOST_BAUD_RATE)

###############################################################################
# OND options
DEV_TYPE = 0x08010001
ifeq ($(JENNIC_CHIP), JN5148)
CHIPSET = 5148
else ifeq ($(JENNIC_CHIP), JN5148J01)
CHIPSET = 5149
else ifeq ($(JENNIC_CHIP), JN5168)
CHIPSET = 5168
else
$(error Unknown chip "$(JENNIC_CHIP)", unable to set CHIPSET)
endif

REVISION = 0x$(VERSION_MAJOR)$(VERSION_MINOR)$(VERSION_BUILD)

CFLAGS += -DVERSION=\"$(VERSION_MAJOR).$(VERSION_MINOR).$(VERSION_BUILD)\"
CFLAGS += -DVERSION_MAJOR=$(VERSION_MAJOR)
CFLAGS += -DVERSION_MINOR=$(VERSION_MINOR)
CFLAGS += -DVERSION_BUILD=$(VERSION_BUILD)

ifeq ($(JENNIC_CHIP), JN5148)
ONDFLAGS += -s $(SDK_BASE_DIR)/Chip/JN5148/Build/SSBL_64k.bin

LDFLAGS += -Wl,--defsym,OND_DEV_TYPE=$(DEV_TYPE)
LDFLAGS += -Wl,--defsym,OND_CHIPSET=$(CHIPSET)
LDFLAGS += -Wl,--defsym,OND_REVISION=$(REVISION)
else
	ifeq ($(JENNIC_CHIP), JN5168)
		ONDFLAGS += -6 -v $(DEV_TYPE) $(CHIPSET) $(REVISION)
	else
		ONDFLAGS += -v $(DEV_TYPE) $(CHIPSET) $(REVISION)
	endif
endif

###############################################################################
# Select the network stack (e.g. MAC, ZBPro, SE)

ifeq ($(JENNIC_CHIP), JN5148)
	JENNIC_STACK ?= None
else
	ifeq ($(JENNIC_CHIP), JN5168)
		JENNIC_STACK ?= JIP
	else
		JENNIC_STACK ?= MAC
	endif
endif

###############################################################################
# Select the bootloader (None or SSBL)

ifeq ($(JENNIC_CHIP), JN5148)
	JENNIC_BOOT  ?= SSBL
else
	JENNIC_BOOT  ?= None
endif

###############################################################################
# SDK required options
CFLAGS += -DLIBRARY_BUILD
CFLAGS += -DEMBEDDED
CFLAGS += -DJENNIC_CHIP_$(JENNIC_CHIP)
CFLAGS += -DARCH_IS_BIG_ENDIAN=1

###############################################################################
# Path definitions

# Use if application directory contains multiple targets
SDK_BASE_DIR   	 	= $(abspath ../../../..)
APP_BASE           	= $(abspath ../..)
APP_BLD_DIR			= $(APP_BASE)/Node/Build
APP_SRC_DIR 	   	= $(APP_BASE)/Node/Source
APP_COMMON_SRC_DIR  = $(APP_BASE)/Common/Source

###############################################################################
# Application Source files

# Note: Path to source file is found using vpath below, so only .c filename is required
APPSRC  = JIP-Gateway.c
APPSRC += Queue.c
APPSRC += UartBuffered.c
APPSRC += SerialLink.c
APPSRC += RADIUS.c
APPSRC += md5.c
APPSRC += Exceptions.c
APPSRC += ModuleConfig.c

ifeq ($(NWK_TEST_MIB), 1)
APPSRC += MibNwkTest.c
endif

###############################################################################
# Application libraries
# Specify additional Component libraries

APPLIBS += DBG
APPLIBS += JIP
APPLIBS += 6LP
APPLIBS += JenNet

###############################################################################
# Standard Application header search paths

INCFLAGS += -I$(APP_SRC_DIR)
INCFLAGS += -I$(APP_SRC_DIR)/..
INCFLAGS += -I$(APP_COMMON_SRC_DIR)
INCFLAGS += -I$(SDK_BASE_DIR)/Tools/ba-elf-ba2/ba-elf/include
INCFLAGS += -I$(SDK_BASE_DIR)/Tools/ba-elf-ba2/usr/include

INCFLAGS += -I$(COMPONENTS_BASE_DIR)/OS/Include

# Application specific include files
INCFLAGS += -I$(COMPONENTS_BASE_DIR)/Utilities/Include
INCFLAGS += -I$(COMPONENTS_BASE_DIR)/JIP/Include

# Debug specific include paths
ifeq ($(TRACE_STACK), 1)
INCFLAGS += -I$(COMPONENTS_BASE_DIR)/6LP/Source
INCFLAGS += -I$(COMPONENTS_BASE_DIR)/MicroSpecific/Include
INCFLAGS += -I$(COMPONENTS_BASE_DIR)/JennicStdLib/Include
endif

###############################################################################

# You should not need to edit below this line

###############################################################################
###############################################################################
# Configure for the selected chip or chip family

include $(SDK_BASE_DIR)/Chip/Common/Build/config.mk
include $(SDK_BASE_DIR)/Platform/Common/Build/Config.mk
include $(SDK_BASE_DIR)/Stack/Common/Build/config.mk

###############################################################################

TEMP = $(APPSRC:.c=.o)
APPOBJS = $(TEMP:.S=.o)

###############################################################################
# Application dynamic dependencies

APPDEPS = $(APPOBJS:.o=.d)

###############################################################################
# Linker

# Add application libraries before chip specific libraries to linker so
# symbols are resolved correctly (i.e. ordering is significant for GCC)

APPLDLIBS := $(foreach lib,$(APPLIBS),$(if $(wildcard $(addprefix $(COMPONENTS_BASE_DIR)/Library/lib,$(addsuffix _$(JENNIC_CHIP).a,$(lib)))),$(addsuffix _$(JENNIC_CHIP),$(lib)),$(addsuffix _$(JENNIC_CHIP_FAMILY),$(lib))))
LDLIBS := $(APPLDLIBS) $(LDLIBS)

###############################################################################
# Dependency rules

.PRECIOUS: %.elf
.PHONY: all clean
# Path to directories containing application source 
vpath % $(APP_SRC_DIR):$(APP_COMMON_SRC_DIR):$(HA_SRC_DIRS)


all: $(TARGET)_$(JENNIC_CHIP)_$(BIN_SUFFIX).bin $(TARGET)_$(JENNIC_CHIP)_$(BIN_SUFFIX).ond


-include $(APPDEPS)
%.d:
	rm -f $*.o

%.o: %.S
	$(info Assembling $< ...)
	$(CC) -c -o $(subst Source,Build,$@) $(CFLAGS) $(INCFLAGS) $< -MD -MF $*.d -MP
	@echo

%.o: %.c 
	$(info Compiling $< ...)
	$(CC) -c -o $(subst Source,Build,$@) $(CFLAGS) $(INCFLAGS) $< -MD -MF $*.d -MP
	@echo

%.elf: $(APPOBJS) $(addsuffix .a,$(addprefix $(COMPONENTS_BASE_DIR)/Library/lib,$(APPLDLIBS))) 
	$(info Linking $@ ...)
	$(CC) -Wl,--gc-sections -Wl,-u_AppColdStart -Wl,-u_AppWarmStart $(LDFLAGS) $(ONDLDFLAGS) -T$(LINKCMD) -o $@ -Wl,--start-group $(APPOBJS) $(addprefix -l,$(LDLIBS)) -Wl,--end-group -Wl,-Map,$(TARGET)_$(JENNIC_CHIP)_$(BIN_SUFFIX).map
	$(SIZE) $@
	@echo

%.img: %.elf 
	$(info Generating binary ...)
	$(OBJCOPY) $< $$( $(OBJDUMP) -h $< | sed -n 's/^ *[0-9]* \(.rom[._[:alnum:]]*\).*/-R \1/p' )
	$(OBJCOPY) -S -O binary $< $@
	@echo

%.bin: %.img
	$(info Generating updatable binary ...)
ifeq ($(JENNIC_CHIP), JN5168)
	$(TOOL_BASE_DIR)/OND/OND_Checksum $(ONDFLAGS) $< $@
else
	$(TOOL_BASE_DIR)/OND/OND_Checksum -f $(ONDFLAGS) $< $@
endif
	@echo

%_usb.bin: %.bin
	$(info Generating NXP USB Dongle binary ...)
	$(TOOL_BASE_DIR)/NXP_USBDongle/jn514x_firmware.exe -f $<
	@mv firmware.bin $@
	@echo

%.ond: %.img 
	$(info Generating update binary ...)
	$(TOOL_BASE_DIR)/OND/OND_Checksum -m $(ONDFLAGS) $< $@
	@echo

	
###############################################################################

clean:
	rm -f $(APPOBJS) $(APPDEPS) $(TARGET)_$(JENNIC_CHIP)_$(BIN_SUFFIX).bin $(TARGET)_$(JENNIC_CHIP)_$(BIN_SUFFIX)_usb.bin $(TARGET)_$(JENNIC_CHIP)_$(BIN_SUFFIX).img $(TARGET)_$(JENNIC_CHIP)_$(BIN_SUFFIX).ond $(TARGET)_$(JENNIC_CHIP)_$(BIN_SUFFIX).elf $(TARGET)_$(JENNIC_CHIP)_$(BIN_SUFFIX).map

cleanall:
	rm -f *.bin *.ond *.elf *.map $(APPOBJS) $(APPDEPS)
	
###############################################################################
