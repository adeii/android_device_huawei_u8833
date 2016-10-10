LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES:=                                      \
                  BandwidthController.cpp              \
                  ClatdController.cpp                  \
                  CommandListener.cpp                  \
                  DnsProxyListener.cpp                 \
                  FirewallController.cpp               \
                  IdletimerController.cpp              \
                  InterfaceController.cpp              \
                  MDnsSdListener.cpp                   \
                  NatController.cpp                    \
                  NetdCommand.cpp                      \
                  NetdConstants.cpp                    \
                  NetlinkHandler.cpp                   \
                  NetlinkManager.cpp                   \
                  PppController.cpp                    \
                  ResolverController.cpp               \
                  SecondaryTableController.cpp         \
                  TetherController.cpp                 \
                  oem_iptables_hook.cpp                \
                  UidMarkMap.cpp                       \
                  main.cpp                             \


LOCAL_MODULE:= netd

LOCAL_C_INCLUDES := $(KERNEL_HEADERS) \
                    external/mdnsresponder/mDNSShared \
                    external/openssl/include \
                    external/stlport/stlport \
                    bionic \
                    bionic/libc/private \
                    $(call include-path-for, libhardware_legacy)/hardware_legacy

LOCAL_CFLAGS := -Werror=format

LOCAL_SHARED_LIBRARIES := libstlport libsysutils liblog libcutils libnetutils \
                          libcrypto libhardware_legacy libmdnssd libdl \
                          liblogwrap

						  ifeq ($(BOARD_HAS_ATH_WLAN),true)
  LOCAL_CFLAGS += -DATH_WLAN
  LOCAL_CFLAGS += -DWIFI_MODULE_PATH=\"$(WIFI_DRIVER_MODULE_PATH)\"
  LOCAL_C_INCLUDES += external/wpa_supplicant_8/wpa_supplicant/src/common
  LOCAL_SRC_FILES += SoftapControllerATH.cpp
  LOCAL_SHARED_LIBRARIES := $(LOCAL_SHARED_LIBRARIES) libwpa_client
else
   LOCAL_SRC_FILES += SoftapController.cpp
endif

include $(BUILD_EXECUTABLE)

include $(CLEAR_VARS)
LOCAL_SRC_FILES:=          \
                  ndc.c \

LOCAL_MODULE:= ndc

LOCAL_C_INCLUDES := $(KERNEL_HEADERS)

LOCAL_CFLAGS := 

LOCAL_SHARED_LIBRARIES := libcutils

include $(BUILD_EXECUTABLE)
