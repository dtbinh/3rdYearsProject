###########################################################################
## Makefile generated for Simulink model 'untitled'. 
## 
## Makefile     : untitled.mk
## Generated on : Wed Sep 20 21:01:31 2017
## MATLAB Coder version: 3.3 (R2017a)
## 
## Build Info:
## 
## Final product: $(RELATIVE_PATH_TO_ANCHOR)/untitled.elf
## Product type : executable
## Build type   : Top-Level Standalone Executable
## 
###########################################################################

###########################################################################
## MACROS
###########################################################################

# Macro Descriptions:
# PRODUCT_NAME            Name of the system to build
# MAKEFILE                Name of this makefile
# COMPUTER                Computer type. See the MATLAB "computer" command.

PRODUCT_NAME              = untitled
MAKEFILE                  = untitled.mk
COMPUTER                  = PCWIN64
MATLAB_ROOT               = C:/PROGRA~1/MATLAB/R2017a
MATLAB_BIN                = C:/PROGRA~1/MATLAB/R2017a/bin
MATLAB_ARCH_BIN           = C:/PROGRA~1/MATLAB/R2017a/bin/win64
MASTER_ANCHOR_DIR         = 
START_DIR                 = D:/chin/mine BCH project/Module6-7/control/lecture/parameter_estimation
ARCH                      = win64
SOLVER                    = 
SOLVER_OBJ                = 
CLASSIC_INTERFACE         = 0
TGT_FCN_LIB               = None
MODEL_HAS_DYNAMICALLY_LOADED_SFCNS = 0
MODELREF_LINK_RSPFILE_NAME = untitled_ref.rsp
RELATIVE_PATH_TO_ANCHOR   = ..
C_STANDARD_OPTS           = 
CPP_STANDARD_OPTS         = 

###########################################################################
## TOOLCHAIN SPECIFICATIONS
###########################################################################

# Toolchain Name:          GNU Tools for ARM Embedded Processors v5.2 | gmake (64-bit Windows)
# Supported Version(s):    
# ToolchainInfo Version:   R2017a
# Specification Revision:  1.0
# 
#-------------------------------------------
# Macros assumed to be defined elsewhere
#-------------------------------------------

# TARGET_LOAD_CMD_ARGS
# TARGET_LOAD_CMD
# MW_GNU_ARM_TOOLS_PATH
# FDATASECTIONS_FLG

#-----------
# MACROS
#-----------

LIBGCC                = ${shell arm-none-eabi-gcc ${CFLAGS} -print-libgcc-file-name}
LIBC                  = ${shell arm-none-eabi-gcc ${CFLAGS} -print-file-name=libc.a}
LIBM                  = ${shell arm-none-eabi-gcc ${CFLAGS} -print-file-name=libm.a}
PRODUCT_BIN           = $(RELATIVE_PATH_TO_ANCHOR)/$(PRODUCT_NAME).bin
PRODUCT_HEX           = $(RELATIVE_PATH_TO_ANCHOR)/$(PRODUCT_NAME).hex
CPFLAGS               = -O binary
SHELL                 = %SystemRoot%/system32/cmd.exe

TOOLCHAIN_SRCS = 
TOOLCHAIN_INCS = 
TOOLCHAIN_LIBS = -lm

#------------------------
# BUILD TOOL COMMANDS
#------------------------

# Assembler: GNU ARM Assembler
AS_PATH = $(MW_GNU_ARM_TOOLS_PATH)
AS = $(AS_PATH)/arm-none-eabi-gcc

# C Compiler: GNU ARM C Compiler
CC_PATH = $(MW_GNU_ARM_TOOLS_PATH)
CC = $(CC_PATH)/arm-none-eabi-gcc

# Linker: GNU ARM Linker
LD_PATH = $(MW_GNU_ARM_TOOLS_PATH)
LD = $(LD_PATH)/arm-none-eabi-g++

# C++ Compiler: GNU ARM C++ Compiler
CPP_PATH = $(MW_GNU_ARM_TOOLS_PATH)
CPP = $(CPP_PATH)/arm-none-eabi-g++

# C++ Linker: GNU ARM C++ Linker
CPP_LD_PATH = $(MW_GNU_ARM_TOOLS_PATH)
CPP_LD = $(CPP_LD_PATH)/arm-none-eabi-g++

# Archiver: GNU ARM Archiver
AR_PATH = $(MW_GNU_ARM_TOOLS_PATH)
AR = $(AR_PATH)/arm-none-eabi-ar

# MEX Tool: MEX Tool
MEX_PATH = $(MATLAB_BIN)
MEX = $(MEX_PATH)/mex

# Binary Converter: Binary Converter
OBJCOPYPATH = $(MW_GNU_ARM_TOOLS_PATH)
OBJCOPY = $(OBJCOPYPATH)/arm-none-eabi-objcopy

# Hex Converter: Hex Converter
OBJCOPYPATH = $(MW_GNU_ARM_TOOLS_PATH)
OBJCOPY = $(OBJCOPYPATH)/arm-none-eabi-objcopy

# Executable Size: Executable Size
EXESIZEPATH = $(MW_GNU_ARM_TOOLS_PATH)
EXESIZE = $(EXESIZEPATH)/arm-none-eabi-size

# Download: Download
DOWNLOAD =

# Execute: Execute
EXECUTE = $(PRODUCT)

# Builder: GMAKE Utility
MAKE_PATH = %MATLAB%\bin\win64
MAKE = $(MAKE_PATH)/gmake


#-------------------------
# Directives/Utilities
#-------------------------

ASDEBUG             = -g
AS_OUTPUT_FLAG      = -o
CDEBUG              = -g
C_OUTPUT_FLAG       = -o
LDDEBUG             = -g
OUTPUT_FLAG         = -o
CPPDEBUG            = -g
CPP_OUTPUT_FLAG     = -o
CPPLDDEBUG          = -g
OUTPUT_FLAG         = -o
ARDEBUG             =
STATICLIB_OUTPUT_FLAG =
MEX_DEBUG           = -g
RM                  = @del /f/q
ECHO                = @echo
MV                  = @move
RUN                 =

#----------------------------------------
# "Faster Builds" Build Configuration
#----------------------------------------

ARFLAGS              = ruvs
ASFLAGS              = -MMD -MP -MF"$(@:%.o=%.dep)" -MT"$@"  \
                       -Wall \
                       -x assembler-with-cpp \
                       $(ASFLAGS_ADDITIONAL) \
                       $(DEFINES) \
                       $(INCLUDES) \
                       -c
OBJCOPYFLAGS_BIN     = -O binary $(PRODUCT) $(PRODUCT_BIN)
CFLAGS               = $(FDATASECTIONS_FLG) \
                       -Wall \
                       -MMD -MP -MF"$(@:%.o=%.dep)" -MT"$@"  \
                       -c \
                       -O0
CPPFLAGS             = -std=c++98 \
                       -fno-rtti \
                       -fno-exceptions \
                       $(FDATASECTIONS_FLG) \
                       -Wall \
                       -MMD -MP -MF"$(@:%.o=%.dep)" -MT"$@"  \
                       -c \
                       -O0
CPP_LDFLAGS          = -Wl,--gc-sections \
                       -Wl,-Map="$(PRODUCT_NAME).map"
CPP_SHAREDLIB_LDFLAGS  =
DOWNLOAD_FLAGS       =
EXESIZE_FLAGS        = $(PRODUCT)
EXECUTE_FLAGS        =
OBJCOPYFLAGS_HEX     = -O ihex $(PRODUCT) $(PRODUCT_HEX)
LDFLAGS              = -Wl,--gc-sections \
                       -Wl,-Map="$(PRODUCT_NAME).map"
MEX_CPPFLAGS         =
MEX_CPPLDFLAGS       =
MEX_CFLAGS           =
MEX_LDFLAGS          =
MAKE_FLAGS           = -f $(MAKEFILE)
SHAREDLIB_LDFLAGS    =

#--------------------
# File extensions
#--------------------

ASM_Type1_Ext       = .S
DEP_EXT             = .dep
OBJ_EXT             = .o
ASM_EXT             = .s
DEP_EXT             = .dep
H_EXT               = .h
OBJ_EXT             = .o
C_EXT               = .c
EXE_EXT             = .elf
SHAREDLIB_EXT       = .so
CXX_EXT             = .cxx
DEP_EXT             = .dep
HPP_EXT             = .hpp
OBJ_EXT             = .o
CPP_EXT             = .cpp
UNIX_TYPE1_EXT      = .cc
UNIX_TYPE2_EXT      = .C
EXE_EXT             = .elf
SHAREDLIB_EXT       = .so
STATICLIB_EXT       = .lib
MEX_EXT             = .mexw64
MAKE_EXT            = .mk


###########################################################################
## OUTPUT INFO
###########################################################################

PRODUCT = $(RELATIVE_PATH_TO_ANCHOR)/untitled.elf
PRODUCT_TYPE = "executable"
BUILD_TYPE = "Top-Level Standalone Executable"

###########################################################################
## INCLUDE PATHS
###########################################################################

INCLUDES_BUILDINFO = -I$(START_DIR) -IC:/ProgramData/MATLAB/SupportPackages/R2017a/toolbox/target/supportpackages/freedomboard/include -I$(START_DIR)/untitled_ert_rtw -I$(MATLAB_ROOT)/extern/include -I$(MATLAB_ROOT)/simulink/include -I$(MATLAB_ROOT)/rtw/c/src -I$(MATLAB_ROOT)/rtw/c/src/ext_mode/common -I$(MATLAB_ROOT)/rtw/c/ert -IC:/ProgramData/MATLAB/SupportPackages/R2017a/3P.instrset/mbedlibrary-stm.instrset/6c34061e7c34 -IC:/ProgramData/MATLAB/SupportPackages/R2017a/3P.instrset/mbedlibrary-stm.instrset/6c34061e7c34/TARGET_KL25Z -IC:/ProgramData/MATLAB/SupportPackages/R2017a/3P.instrset/mbedlibrary-stm.instrset/6c34061e7c34/TARGET_KL25Z/TARGET_Freescale -IC:/ProgramData/MATLAB/SupportPackages/R2017a/3P.instrset/mbedlibrary-stm.instrset/6c34061e7c34/TARGET_KL25Z/TARGET_Freescale/TARGET_KLXX -IC:/ProgramData/MATLAB/SupportPackages/R2017a/3P.instrset/mbedlibrary-stm.instrset/6c34061e7c34/TARGET_KL25Z/TARGET_Freescale/TARGET_KLXX/TARGET_KL25Z -IC:/ProgramData/MATLAB/SupportPackages/R2017a/3P.instrset/mbedlibrary-stm.instrset/6c34061e7c34/TARGET_KL25Z/TOOLCHAIN_GCC_ARM -IC:/ProgramData/MATLAB/SupportPackages/R2017a/3P.instrset/cmsis.instrset/CMSIS/Include -I$(MATLAB_ROOT)/rtw/c/src/ext_mode/serial -IC:/ProgramData/MATLAB/SupportPackages/R2017a/toolbox/target/supportpackages/armcortexmbase/scheduler/include

INCLUDES = $(INCLUDES_BUILDINFO)

###########################################################################
## DEFINES
###########################################################################

DEFINES_ = -DMODEL=untitled -DNUMST=1 -DNCSTATES=0 -DHAVESTDIO -DTERMFCN=1 -DONESTEPFCN=1 -DMAT_FILE=0 -DMULTI_INSTANCE_CODE=0 -DINTEGER_CODE=0 -DMT=0 -DCLASSIC_INTERFACE=0 -DALLOCATIONFCN=0 -DTID01EQ=0 -DNULL=0 -DEXIT_FAILURE=1 -DEXTMODE_DISABLEPRINTF -DEXTMODE_DISABLETESTING -DEXTMODE_DISABLE_ARGS_PROCESSING=1 -DTARGET_KL25Z -DTARGET_M0P -DTARGET_Freescale -DTOOLCHAIN_GCC_ARM -DTOOLCHAIN_GCC -D__CORTEX_M0PLUS -DARM_MATH_CM0PLUS -DTARGET_FF_ARDUINO -DTARGET_KLXX -DTARGET_CORTEX_M -DTARGET_LIKE_MBED -D__MBED__=1 -DTARGET_LIKE_CORTEX_M0 -DSTACK_SIZE=64 -D__MW_TARGET_USE_HARDWARE_RESOURCES_H__ -DRT
DEFINES_BUILD_ARGS = -DTERMFCN=1 -DONESTEPFCN=1 -DMAT_FILE=0 -DMULTI_INSTANCE_CODE=0 -DINTEGER_CODE=0 -DMT=0 -DCLASSIC_INTERFACE=0 -DALLOCATIONFCN=0
DEFINES_IMPLIED = -DTID01EQ=0
DEFINES_SKIPFORSIL = -DNULL=0 -DEXIT_FAILURE=1 -DEXTMODE_DISABLEPRINTF -DEXTMODE_DISABLETESTING -DEXTMODE_DISABLE_ARGS_PROCESSING=1 -DTARGET_KL25Z -DTARGET_M0P -DTARGET_Freescale -DTOOLCHAIN_GCC_ARM -DTOOLCHAIN_GCC -D__CORTEX_M0PLUS -DARM_MATH_CM0PLUS -DTARGET_FF_ARDUINO -DTARGET_KLXX -DTARGET_CORTEX_M -DTARGET_LIKE_MBED -D__MBED__=1 -DTARGET_LIKE_CORTEX_M0 -DSTACK_SIZE=64 -DRT
DEFINES_STANDARD = -DMODEL=untitled -DNUMST=1 -DNCSTATES=0 -DHAVESTDIO

DEFINES = $(DEFINES_) $(DEFINES_BUILD_ARGS) $(DEFINES_IMPLIED) $(DEFINES_SKIPFORSIL) $(DEFINES_STANDARD)

###########################################################################
## SOURCE FILES
###########################################################################

SRCS = C:/ProgramData/MATLAB/SupportPackages/R2017a/toolbox/target/supportpackages/freedomboard/src/rgbled_wrapper.cpp $(START_DIR)/untitled_ert_rtw/untitled.c $(START_DIR)/untitled_ert_rtw/untitled_data.c C:/ProgramData/MATLAB/SupportPackages/R2017a/toolbox/target/supportpackages/freedomboard/src/BoardInit.c C:/ProgramData/MATLAB/SupportPackages/R2017a/toolbox/target/supportpackages/freedomboard/src/BufferedSerial.cpp C:/ProgramData/MATLAB/SupportPackages/R2017a/toolbox/target/supportpackages/armcortexmbase/scheduler/src/SysTickScheduler.c C:/ProgramData/MATLAB/SupportPackages/R2017a/toolbox/target/supportpackages/armcortexmbase/scheduler/src/m0m1m0plus_multitasking.c

MAIN_SRC = $(START_DIR)/untitled_ert_rtw/ert_main.c

ALL_SRCS = $(SRCS) $(MAIN_SRC)

###########################################################################
## OBJECTS
###########################################################################

OBJS = rgbled_wrapper.o untitled.o untitled_data.o BoardInit.o BufferedSerial.o SysTickScheduler.o m0m1m0plus_multitasking.o

MAIN_OBJ = ert_main.o

ALL_OBJS = $(OBJS) $(MAIN_OBJ)

###########################################################################
## PREBUILT OBJECT FILES
###########################################################################

PREBUILT_OBJS = 

###########################################################################
## LIBRARIES
###########################################################################

LIBS = C:/ProgramData/MATLAB/SupportPackages/R2017a/3P.instrset/mbedlibrary-stm.instrset/6c34061e7c34/TARGET_KL25Z/TOOLCHAIN_GCC_ARM/libmbed.a C:/ProgramData/MATLAB/SupportPackages/R2017a/3P.instrset/cmsis.instrset/CMSIS/Lib/GCC/libarm_cortexM0l_math.a

###########################################################################
## SYSTEM LIBRARIES
###########################################################################

SYSTEM_LIBS = 

###########################################################################
## ADDITIONAL TOOLCHAIN FLAGS
###########################################################################

#---------------
# C Compiler
#---------------

CFLAGS_SKIPFORSIL = -mcpu=cortex-m0plus -mthumb -fno-exceptions -fno-common -fmessage-length=0
CFLAGS_BASIC = $(DEFINES) $(INCLUDES)

CFLAGS += $(CFLAGS_SKIPFORSIL) $(CFLAGS_BASIC)

#-----------------
# C++ Compiler
#-----------------

CPPFLAGS_SKIPFORSIL = -mcpu=cortex-m0plus -mthumb -fno-exceptions -fno-common -fmessage-length=0
CPPFLAGS_BASIC = $(DEFINES) $(INCLUDES)

CPPFLAGS += $(CPPFLAGS_SKIPFORSIL) $(CPPFLAGS_BASIC)

#---------------
# C++ Linker
#---------------

CPP_LDFLAGS_SKIPFORSIL = -mcpu=cortex-m0plus -mthumb --specs=nano.specs --specs=nosys.specs -T"C:/PROGRA~3/MATLAB/SUPPOR~1/R2017a/3P778C~1.INS/MBEDLI~1.INS/6C3406~1/TARGET_KL25Z/TOOLCHAIN_GCC_ARM/MKL25Z4.ld" "C:/PROGRA~3/MATLAB/SUPPOR~1/R2017a/3P778C~1.INS/MBEDLI~1.INS/6C3406~1/TARGET_KL25Z/TOOLCHAIN_GCC_ARM/cmsis_nvic.o" "C:/PROGRA~3/MATLAB/SUPPOR~1/R2017a/3P778C~1.INS/MBEDLI~1.INS/6C3406~1/TARGET_KL25Z/TOOLCHAIN_GCC_ARM/startup_MKL25Z4.o" "C:/PROGRA~3/MATLAB/SUPPOR~1/R2017a/3P778C~1.INS/MBEDLI~1.INS/6C3406~1/TARGET_KL25Z/TOOLCHAIN_GCC_ARM/retarget.o" "C:/PROGRA~3/MATLAB/SUPPOR~1/R2017a/3P778C~1.INS/MBEDLI~1.INS/6C3406~1/TARGET_KL25Z/TOOLCHAIN_GCC_ARM/system_MKL25Z4.o" "C:/PROGRA~3/MATLAB/SUPPOR~1/R2017a/3P778C~1.INS/MBEDLI~1.INS/6C3406~1/TARGET_KL25Z/TOOLCHAIN_GCC_ARM/board.o" "C:/PROGRA~3/MATLAB/SUPPOR~1/R2017a/3P778C~1.INS/MBEDLI~1.INS/6C3406~1/TARGET_KL25Z/TOOLCHAIN_GCC_ARM/mbed_overrides.o"

CPP_LDFLAGS += $(CPP_LDFLAGS_SKIPFORSIL)

#------------------------------
# C++ Shared Library Linker
#------------------------------

CPP_SHAREDLIB_LDFLAGS_SKIPFORSIL = -mcpu=cortex-m0plus -mthumb --specs=nano.specs --specs=nosys.specs -T"C:/PROGRA~3/MATLAB/SUPPOR~1/R2017a/3P778C~1.INS/MBEDLI~1.INS/6C3406~1/TARGET_KL25Z/TOOLCHAIN_GCC_ARM/MKL25Z4.ld" "C:/PROGRA~3/MATLAB/SUPPOR~1/R2017a/3P778C~1.INS/MBEDLI~1.INS/6C3406~1/TARGET_KL25Z/TOOLCHAIN_GCC_ARM/cmsis_nvic.o" "C:/PROGRA~3/MATLAB/SUPPOR~1/R2017a/3P778C~1.INS/MBEDLI~1.INS/6C3406~1/TARGET_KL25Z/TOOLCHAIN_GCC_ARM/startup_MKL25Z4.o" "C:/PROGRA~3/MATLAB/SUPPOR~1/R2017a/3P778C~1.INS/MBEDLI~1.INS/6C3406~1/TARGET_KL25Z/TOOLCHAIN_GCC_ARM/retarget.o" "C:/PROGRA~3/MATLAB/SUPPOR~1/R2017a/3P778C~1.INS/MBEDLI~1.INS/6C3406~1/TARGET_KL25Z/TOOLCHAIN_GCC_ARM/system_MKL25Z4.o" "C:/PROGRA~3/MATLAB/SUPPOR~1/R2017a/3P778C~1.INS/MBEDLI~1.INS/6C3406~1/TARGET_KL25Z/TOOLCHAIN_GCC_ARM/board.o" "C:/PROGRA~3/MATLAB/SUPPOR~1/R2017a/3P778C~1.INS/MBEDLI~1.INS/6C3406~1/TARGET_KL25Z/TOOLCHAIN_GCC_ARM/mbed_overrides.o"

CPP_SHAREDLIB_LDFLAGS += $(CPP_SHAREDLIB_LDFLAGS_SKIPFORSIL)

#-----------
# Linker
#-----------

LDFLAGS_SKIPFORSIL = -mcpu=cortex-m0plus -mthumb --specs=nano.specs --specs=nosys.specs -T"C:/PROGRA~3/MATLAB/SUPPOR~1/R2017a/3P778C~1.INS/MBEDLI~1.INS/6C3406~1/TARGET_KL25Z/TOOLCHAIN_GCC_ARM/MKL25Z4.ld" "C:/PROGRA~3/MATLAB/SUPPOR~1/R2017a/3P778C~1.INS/MBEDLI~1.INS/6C3406~1/TARGET_KL25Z/TOOLCHAIN_GCC_ARM/cmsis_nvic.o" "C:/PROGRA~3/MATLAB/SUPPOR~1/R2017a/3P778C~1.INS/MBEDLI~1.INS/6C3406~1/TARGET_KL25Z/TOOLCHAIN_GCC_ARM/startup_MKL25Z4.o" "C:/PROGRA~3/MATLAB/SUPPOR~1/R2017a/3P778C~1.INS/MBEDLI~1.INS/6C3406~1/TARGET_KL25Z/TOOLCHAIN_GCC_ARM/retarget.o" "C:/PROGRA~3/MATLAB/SUPPOR~1/R2017a/3P778C~1.INS/MBEDLI~1.INS/6C3406~1/TARGET_KL25Z/TOOLCHAIN_GCC_ARM/system_MKL25Z4.o" "C:/PROGRA~3/MATLAB/SUPPOR~1/R2017a/3P778C~1.INS/MBEDLI~1.INS/6C3406~1/TARGET_KL25Z/TOOLCHAIN_GCC_ARM/board.o" "C:/PROGRA~3/MATLAB/SUPPOR~1/R2017a/3P778C~1.INS/MBEDLI~1.INS/6C3406~1/TARGET_KL25Z/TOOLCHAIN_GCC_ARM/mbed_overrides.o"

LDFLAGS += $(LDFLAGS_SKIPFORSIL)

#--------------------------
# Shared Library Linker
#--------------------------

SHAREDLIB_LDFLAGS_SKIPFORSIL = -mcpu=cortex-m0plus -mthumb --specs=nano.specs --specs=nosys.specs -T"C:/PROGRA~3/MATLAB/SUPPOR~1/R2017a/3P778C~1.INS/MBEDLI~1.INS/6C3406~1/TARGET_KL25Z/TOOLCHAIN_GCC_ARM/MKL25Z4.ld" "C:/PROGRA~3/MATLAB/SUPPOR~1/R2017a/3P778C~1.INS/MBEDLI~1.INS/6C3406~1/TARGET_KL25Z/TOOLCHAIN_GCC_ARM/cmsis_nvic.o" "C:/PROGRA~3/MATLAB/SUPPOR~1/R2017a/3P778C~1.INS/MBEDLI~1.INS/6C3406~1/TARGET_KL25Z/TOOLCHAIN_GCC_ARM/startup_MKL25Z4.o" "C:/PROGRA~3/MATLAB/SUPPOR~1/R2017a/3P778C~1.INS/MBEDLI~1.INS/6C3406~1/TARGET_KL25Z/TOOLCHAIN_GCC_ARM/retarget.o" "C:/PROGRA~3/MATLAB/SUPPOR~1/R2017a/3P778C~1.INS/MBEDLI~1.INS/6C3406~1/TARGET_KL25Z/TOOLCHAIN_GCC_ARM/system_MKL25Z4.o" "C:/PROGRA~3/MATLAB/SUPPOR~1/R2017a/3P778C~1.INS/MBEDLI~1.INS/6C3406~1/TARGET_KL25Z/TOOLCHAIN_GCC_ARM/board.o" "C:/PROGRA~3/MATLAB/SUPPOR~1/R2017a/3P778C~1.INS/MBEDLI~1.INS/6C3406~1/TARGET_KL25Z/TOOLCHAIN_GCC_ARM/mbed_overrides.o"

SHAREDLIB_LDFLAGS += $(SHAREDLIB_LDFLAGS_SKIPFORSIL)

###########################################################################
## INLINED COMMANDS
###########################################################################


ALL_DEPS:=$(patsubst %$(OBJ_EXT),%$(DEP_EXT),$(ALL_OBJS))

ifndef DISABLE_GCC_FUNCTION_DATA_SECTIONS
FDATASECTIONS_FLG := -ffunction-sections -fdata-sections
endif



-include codertarget_assembly_flags.mk
-include ../codertarget_assembly_flags.mk
-include $(ALL_DEPS)


###########################################################################
## PHONY TARGETS
###########################################################################

.PHONY : all build buildobj clean info prebuild postbuild download execute


all : build postbuild
	@echo "### Successfully generated all binary outputs."


build : prebuild $(PRODUCT)


buildobj : prebuild $(OBJS) $(PREBUILT_OBJS) $(LIBS)
	@echo "### Successfully generated all binary outputs."


prebuild : 


postbuild : build
	@echo "### Invoking postbuild tool "Binary Converter" ..."
	$(OBJCOPY) $(OBJCOPYFLAGS_BIN)
	@echo "### Done invoking postbuild tool."
	@echo "### Invoking postbuild tool "Hex Converter" ..."
	$(OBJCOPY) $(OBJCOPYFLAGS_HEX)
	@echo "### Done invoking postbuild tool."
	@echo "### Invoking postbuild tool "Executable Size" ..."
	$(EXESIZE) $(EXESIZE_FLAGS)
	@echo "### Done invoking postbuild tool."


download : postbuild


execute : download
	@echo "### Invoking postbuild tool "Execute" ..."
	$(EXECUTE) $(EXECUTE_FLAGS)
	@echo "### Done invoking postbuild tool."


###########################################################################
## FINAL TARGET
###########################################################################

#-------------------------------------------
# Create a standalone executable            
#-------------------------------------------

$(PRODUCT) : $(OBJS) $(PREBUILT_OBJS) $(LIBS) $(MAIN_OBJ)
	@echo "### Creating standalone executable "$(PRODUCT)" ..."
	$(CPP_LD) $(CPP_LDFLAGS) -o $(PRODUCT) $(OBJS) $(MAIN_OBJ) $(LIBS) $(SYSTEM_LIBS) $(TOOLCHAIN_LIBS)
	@echo "### Created: $(PRODUCT)"


###########################################################################
## INTERMEDIATE TARGETS
###########################################################################

#---------------------
# SOURCE-TO-OBJECT
#---------------------

%.o : %.c
	$(CC) $(CFLAGS) -o $@ $<


%.o : %.s
	$(AS) $(ASFLAGS) -o $@ $<


%.o : %.S
	$(AS) $(ASFLAGS) -o $@ $<


%.o : %.cpp
	$(CPP) $(CPPFLAGS) -o $@ $<


%.o : %.cc
	$(CPP) $(CPPFLAGS) -o $@ $<


%.o : %.C
	$(CPP) $(CPPFLAGS) -o $@ $<


%.o : %.cxx
	$(CPP) $(CPPFLAGS) -o $@ $<


%.o : $(RELATIVE_PATH_TO_ANCHOR)/%.c
	$(CC) $(CFLAGS) -o $@ $<


%.o : $(RELATIVE_PATH_TO_ANCHOR)/%.s
	$(AS) $(ASFLAGS) -o $@ $<


%.o : $(RELATIVE_PATH_TO_ANCHOR)/%.S
	$(AS) $(ASFLAGS) -o $@ $<


%.o : $(RELATIVE_PATH_TO_ANCHOR)/%.cpp
	$(CPP) $(CPPFLAGS) -o $@ $<


%.o : $(RELATIVE_PATH_TO_ANCHOR)/%.cc
	$(CPP) $(CPPFLAGS) -o $@ $<


%.o : $(RELATIVE_PATH_TO_ANCHOR)/%.C
	$(CPP) $(CPPFLAGS) -o $@ $<


%.o : $(RELATIVE_PATH_TO_ANCHOR)/%.cxx
	$(CPP) $(CPPFLAGS) -o $@ $<


%.o : $(START_DIR)/%.c
	$(CC) $(CFLAGS) -o $@ $<


%.o : $(START_DIR)/%.s
	$(AS) $(ASFLAGS) -o $@ $<


%.o : $(START_DIR)/%.S
	$(AS) $(ASFLAGS) -o $@ $<


%.o : $(START_DIR)/%.cpp
	$(CPP) $(CPPFLAGS) -o $@ $<


%.o : $(START_DIR)/%.cc
	$(CPP) $(CPPFLAGS) -o $@ $<


%.o : $(START_DIR)/%.C
	$(CPP) $(CPPFLAGS) -o $@ $<


%.o : $(START_DIR)/%.cxx
	$(CPP) $(CPPFLAGS) -o $@ $<


%.o : $(START_DIR)/untitled_ert_rtw/%.c
	$(CC) $(CFLAGS) -o $@ $<


%.o : $(START_DIR)/untitled_ert_rtw/%.s
	$(AS) $(ASFLAGS) -o $@ $<


%.o : $(START_DIR)/untitled_ert_rtw/%.S
	$(AS) $(ASFLAGS) -o $@ $<


%.o : $(START_DIR)/untitled_ert_rtw/%.cpp
	$(CPP) $(CPPFLAGS) -o $@ $<


%.o : $(START_DIR)/untitled_ert_rtw/%.cc
	$(CPP) $(CPPFLAGS) -o $@ $<


%.o : $(START_DIR)/untitled_ert_rtw/%.C
	$(CPP) $(CPPFLAGS) -o $@ $<


%.o : $(START_DIR)/untitled_ert_rtw/%.cxx
	$(CPP) $(CPPFLAGS) -o $@ $<


%.o : $(MATLAB_ROOT)/rtw/c/src/%.c
	$(CC) $(CFLAGS) -o $@ $<


%.o : $(MATLAB_ROOT)/rtw/c/src/%.s
	$(AS) $(ASFLAGS) -o $@ $<


%.o : $(MATLAB_ROOT)/rtw/c/src/%.S
	$(AS) $(ASFLAGS) -o $@ $<


%.o : $(MATLAB_ROOT)/rtw/c/src/%.cpp
	$(CPP) $(CPPFLAGS) -o $@ $<


%.o : $(MATLAB_ROOT)/rtw/c/src/%.cc
	$(CPP) $(CPPFLAGS) -o $@ $<


%.o : $(MATLAB_ROOT)/rtw/c/src/%.C
	$(CPP) $(CPPFLAGS) -o $@ $<


%.o : $(MATLAB_ROOT)/rtw/c/src/%.cxx
	$(CPP) $(CPPFLAGS) -o $@ $<


%.o : $(MATLAB_ROOT)/simulink/src/%.c
	$(CC) $(CFLAGS) -o $@ $<


%.o : $(MATLAB_ROOT)/simulink/src/%.s
	$(AS) $(ASFLAGS) -o $@ $<


%.o : $(MATLAB_ROOT)/simulink/src/%.S
	$(AS) $(ASFLAGS) -o $@ $<


%.o : $(MATLAB_ROOT)/simulink/src/%.cpp
	$(CPP) $(CPPFLAGS) -o $@ $<


%.o : $(MATLAB_ROOT)/simulink/src/%.cc
	$(CPP) $(CPPFLAGS) -o $@ $<


%.o : $(MATLAB_ROOT)/simulink/src/%.C
	$(CPP) $(CPPFLAGS) -o $@ $<


%.o : $(MATLAB_ROOT)/simulink/src/%.cxx
	$(CPP) $(CPPFLAGS) -o $@ $<


rgbled_wrapper.o : C:/ProgramData/MATLAB/SupportPackages/R2017a/toolbox/target/supportpackages/freedomboard/src/rgbled_wrapper.cpp
	$(CPP) $(CPPFLAGS) -o $@ $<


BoardInit.o : C:/ProgramData/MATLAB/SupportPackages/R2017a/toolbox/target/supportpackages/freedomboard/src/BoardInit.c
	$(CC) $(CFLAGS) -o $@ $<


BufferedSerial.o : C:/ProgramData/MATLAB/SupportPackages/R2017a/toolbox/target/supportpackages/freedomboard/src/BufferedSerial.cpp
	$(CPP) $(CPPFLAGS) -o $@ $<


SysTickScheduler.o : C:/ProgramData/MATLAB/SupportPackages/R2017a/toolbox/target/supportpackages/armcortexmbase/scheduler/src/SysTickScheduler.c
	$(CC) $(CFLAGS) -o $@ $<


m0m1m0plus_multitasking.o : C:/ProgramData/MATLAB/SupportPackages/R2017a/toolbox/target/supportpackages/armcortexmbase/scheduler/src/m0m1m0plus_multitasking.c
	$(CC) $(CFLAGS) -o $@ $<


###########################################################################
## DEPENDENCIES
###########################################################################

$(ALL_OBJS) : $(MAKEFILE) rtw_proj.tmw


###########################################################################
## MISCELLANEOUS TARGETS
###########################################################################

info : 
	@echo "### PRODUCT = $(PRODUCT)"
	@echo "### PRODUCT_TYPE = $(PRODUCT_TYPE)"
	@echo "### BUILD_TYPE = $(BUILD_TYPE)"
	@echo "### INCLUDES = $(INCLUDES)"
	@echo "### DEFINES = $(DEFINES)"
	@echo "### ALL_SRCS = $(ALL_SRCS)"
	@echo "### ALL_OBJS = $(ALL_OBJS)"
	@echo "### LIBS = $(LIBS)"
	@echo "### MODELREF_LIBS = $(MODELREF_LIBS)"
	@echo "### SYSTEM_LIBS = $(SYSTEM_LIBS)"
	@echo "### TOOLCHAIN_LIBS = $(TOOLCHAIN_LIBS)"
	@echo "### ASFLAGS = $(ASFLAGS)"
	@echo "### CFLAGS = $(CFLAGS)"
	@echo "### LDFLAGS = $(LDFLAGS)"
	@echo "### SHAREDLIB_LDFLAGS = $(SHAREDLIB_LDFLAGS)"
	@echo "### CPPFLAGS = $(CPPFLAGS)"
	@echo "### CPP_LDFLAGS = $(CPP_LDFLAGS)"
	@echo "### CPP_SHAREDLIB_LDFLAGS = $(CPP_SHAREDLIB_LDFLAGS)"
	@echo "### ARFLAGS = $(ARFLAGS)"
	@echo "### MEX_CFLAGS = $(MEX_CFLAGS)"
	@echo "### MEX_CPPFLAGS = $(MEX_CPPFLAGS)"
	@echo "### MEX_LDFLAGS = $(MEX_LDFLAGS)"
	@echo "### MEX_CPPLDFLAGS = $(MEX_CPPLDFLAGS)"
	@echo "### OBJCOPYFLAGS_BIN = $(OBJCOPYFLAGS_BIN)"
	@echo "### OBJCOPYFLAGS_HEX = $(OBJCOPYFLAGS_HEX)"
	@echo "### EXESIZE_FLAGS = $(EXESIZE_FLAGS)"
	@echo "### DOWNLOAD_FLAGS = $(DOWNLOAD_FLAGS)"
	@echo "### EXECUTE_FLAGS = $(EXECUTE_FLAGS)"
	@echo "### MAKE_FLAGS = $(MAKE_FLAGS)"


clean : 
	$(ECHO) "### Deleting all derived files..."
	$(RM) $(subst /,\,$(PRODUCT))
	$(RM) $(subst /,\,$(ALL_OBJS))
	$(RM) *.dep
	$(ECHO) "### Deleted all derived files."


