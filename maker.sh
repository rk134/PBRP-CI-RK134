#! /bin/bash

#
# Copyright (C) 2020 StarLight5234
# Copyright (C) 2021 GhostMaster69-dev
# Copyright (C) 2021 rk134

export CHANNEL_ID="-1001750098178"
export TELEGRAM_TOKEN=$BOT_API_KEY
export ZIP_DIR="$(pwd)/work/out/target/product/*/*.zip"
#==============================================================
#===================== Function Definition ====================
#==============================================================
#======================= Telegram Start =======================
#==============================================================

# Upload buildlog to group
tg_erlog()
{
	ERLOG=$HOME/build/build${BUILD}.txt
	curl -F document=@"$ERLOG"  "https://api.telegram.org/bot$TELEGRAM_TOKEN/sendDocument" \
			-F chat_id=$CHANNEL_ID \
			-F caption="Build ran into errors after $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds, plox check logs"
}

# Upload zip to channel
tg_pushzip() 
{
	FZIP=$ZIP_DIR/$ZIP
	curl -F document=@"$FZIP"  "https://api.telegram.org/bot$TELEGRAM_TOKEN/sendDocument" \
			-F chat_id=$CHANNEL_ID \
			-F caption="Build Finished after $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds"
}

# Send Updates
function tg_sendinfo() {
	curl -s "https://api.telegram.org/bot$TELEGRAM_TOKEN/sendMessage" \
		-d "parse_mode=html" \
		-d text="${1}" \
		-d chat_id="${CHANNEL_ID}" \
		-d "disable_web_page_preview=true"
}

# Send a sticker
function start_sticker() {
    curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_TOKEN/sendSticker" \
        -d sticker="CAACAgQAAxkBAAEDIYdhctPrAm1Ydl3sFori9vNNnjAoigAC9AkAAl79YVHW7zfYKT9-XyEE" \
        -d chat_id=$CHANNEL_ID
}

function error_sticker() {
    curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_TOKEN/sendSticker" \
        -d sticker="$STICKER" \
        -d chat_id=$CHANNEL_ID
}

# recovery maker
. build/envsetup.sh && lunch omni_vince-eng && mka recoveryimage


# recovery uploader
cd $ZIP_DIR
dir
ZIP=$(echo *.zip)
tg_pushzip

#==============================================================
#========================= Build Log ==========================
#==============================================================

# Credits: @madeofgreat
BTXT="$HOME/build/buildno.txt" #BTXT is Build number TeXT
if ! [ -a "$BTXT" ]; then
	mkdir $HOME/build
	touch $HOME/build/buildno.txt
	echo $RANDOM > $BTXT
fi

BUILD=$(cat $BTXT)
BUILD=$(($BUILD + 1))
echo ${BUILD} > $BTXT

#==============================================================
#===================== Random sticker =========================
#==================== for build error =========================
#==============================================================

stick=$(($RANDOM % 5))

if [ "$stick" == "0" ]; then
	STICKER="CAACAgIAAxkBAAEDIWhhcssHSMR1HTAHtKOby21tVafvWgAC_gADVp29CtoEYTAu-df_IQQ"
elif [ "$stick" == "1" ];then
	STICKER="CAACAgIAAxkBAAEDIXlhcsvK31evc58huNXRZnSWf62R2AAC_w4AAhSUAAFL2_NFL9rIYIAhBA"
elif [ "$stick" == "2" ];then
	STICKER="CAACAgUAAxkBAAEDIXthcsvYV4zwNP0ousx1ULwkKGRdygACIAADYOojP1RURqxGbEhrIQQ"
elif [ "$stick" == "3" ];then
	STICKER="CAACAgUAAxkBAAEDIX1hcsvr8e6DUr1J4KmHCtI98gx1xwACNgADP9jqMxV1oXRlrlnXIQQ"
elif [ "$stick" == "4" ];then
	STICKER="CAACAgEAAxkBAAEDIYFhcswQNqw8ZPubg7zGQkNhaYGTBAACKwIAAvx0QESn-U6NZyYYfSEE"
fi

#==============================================================
#===================== End of function ========================
#======================= definition ===========================
#==============================================================

clone_tc

COMMIT=$(git log --pretty=format:'"%h : %s"' -1)
BRANCH="$(git rev-parse --abbrev-ref HEAD)"


start_sticker
tg_sendinfo "$(echo -e "======= <b>$DEVICE</b> =======\n
Version        :- <u><b>PBRP-TEST</b></u>
on Branch   :- <b>$BRANCH</b>
Commit       :- <b>$COMMIT</b>\n")"

