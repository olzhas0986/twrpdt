# SPDX-License-Identifier: Apache-2.0
LOCAL_PATH := device/xiaomi/munch

$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

# munch shipped with Android 12; this is independent of the installed ROM API.
PRODUCT_SHIPPING_API_LEVEL := 31
PRODUCT_TARGET_VNDK_VERSION := 31
PRODUCT_USE_DYNAMIC_PARTITIONS := true
ENABLE_VIRTUAL_AB := true
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    odm \
    product \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vendor \
    vendor_boot

PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    vendor/qcom/opensource/commonsys-intf/display

PRODUCT_PACKAGES += \
    android.hardware.boot@1.1-service \
    bootctrl.kona.recovery \
    android.hardware.boot@1.1-impl-qti.recovery \
    android.hardware.health@2.1-service \
    android.hardware.fastboot@1.0-impl-mock \
    android.hardware.fastboot@1.0-impl-mock.recovery \
    fastbootd \
    update_engine_sideload \
    qcom_decrypt \
    qcom_decrypt_fbe

MUNCH_RECOVERY_LIBRARIES := \
    android.hardware.boot@1.0 \
    android.hardware.boot@1.1 \
    android.hardware.gatekeeper@1.0 \
    android.hardware.keymaster@4.0 \
    android.hardware.keymaster@4.1 \
    libbase \
    libbinder \
    libbinder_ndk \
    libc++ \
    libc \
    libcrypto \
    libcutils \
    libdl \
    libhardware \
    libhidlbase \
    libion \
    liblog \
    libm \
    libutils \
    libxml2 \
    libz

TARGET_RECOVERY_DEVICE_MODULES += \
    $(MUNCH_RECOVERY_LIBRARIES) \
    vendor.display.config@1.0 \
    vendor.display.config@2.0
RECOVERY_LIBRARY_SOURCE_FILES += \
    $(foreach lib,$(MUNCH_RECOVERY_LIBRARIES),$(TARGET_OUT_SHARED_LIBRARIES)/$(lib).so) \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@1.0.so \
    $(TARGET_OUT_SYSTEM_EXT_SHARED_LIBRARIES)/vendor.display.config@2.0.so

# Recovery keymaster version binding workaround inherited from TeamWin's munch
# tree. These values are NOT the installed Android version or real patch date.
# Keep out of normal-boot images and revisit when changing the keymaster blobs.
PLATFORM_VERSION := 99.87.36
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
PLATFORM_SECURITY_PATCH := 2127-12-31
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
BOOT_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
