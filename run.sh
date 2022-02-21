git clone https://github.com/rk134/scripts.git && cd scripts && bash setup/android_build_env.sh && cd .. && rm -rf scripts
mkdir twrp
cd twrp
repo init -u git://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git -b twrp-11 --depth=1 --groups=all,-notdefault,-device,-darwin,-x86,-mips
repo sync -j4
git clone https://github.com/rk134/recovery_xiaomi_vince.git -b twrp-11 device/xiaomi/vince
cd twrp
. build/envsetup.sh && lunch twrp_vince-eng && export ALLOW_MISSING_DEPENDENCIES=true && mka recoveryimage
cd $(pwd)/out/target/product/vince
curl -F document=@"*.img" "https://api.telegram.org/bot$TELEGRAM_TOKEN/sendDocument" \
			-F chat_id=$ID \
export ID=$CHANNEL_ID
export TELEGRAM_TOKEN=$BOT_API_KEY
