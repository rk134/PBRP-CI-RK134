git clone https://github.com/rk134/scripts.git && cd scripts && bash setup/android_build_env.sh && cd ..
mkdir PBRP
cd pbrp
repo init -u git://github.com/PitchBlackRecoveryProject/manifest_pb.git -b android-9.0 --depth=1 --groups=all,-notdefault,-device,-darwin,-x86,-mips
repo sync -j4
git clone https://github.com/rxhulkxnt44/recovery_xiaomi_vince.git -b fox_9.0 device/xiaomi/vince
cd pbrp
bash maker.sh
export ID=$ID
export BOT_API_KEY=$BOT_API_KEY
