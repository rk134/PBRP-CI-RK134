mkdir twrp 
cd twrp
repo init -u git://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-11 --depth=1 --groups=all,-notdefault,-device,-darwin,-x86,-mips
repo sync -j4
git clone https://github.com/rk134/recovery_xiaomi_vince.git -b twrp-11 device/xiaomi/vince
cd twrp
. build/envsetup.sh && lunch twrp_vince-eng && export ALLOW_MISSING_DEPENDENCIES=true && mka recoveryimage
cd $(pwd)/out/target/product/vince
curl -T recovery.img temp.sh
export ID=$CHANNEL_ID
export TELEGRAM_TOKEN=$BOT_API_KEY
