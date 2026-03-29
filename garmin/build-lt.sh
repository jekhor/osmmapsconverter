#!/bin/bash

set -e

TEMP_DIR=temp
PBF_FILE=$1
BOUNDS=bounds-latest.zip
#MKGMAP=mkgmap
MKGMAP="java -Xmx3000m -jar mkgmap/mkgmap.jar"
#SPLITTER=mkgmap-splitter
SPLITTER="java -Xmx3000m -jar split/splitter.jar"
OUT_DIR=out

if [[ -n "$PBF_FILE"  ]]
then
    echo "[INFO] using custom PBF_FILE:"
    echo PBF_FILE=$PBF_FILE
else
    echo "[INFO] using default PBF_FILE:"
    export PBF_FILE=../in/belarus.osm.pbf
    echo PBF_FILE=$PBF_FILE
fi


TEMPLATE_ARGS="$TEMP_DIR/template.args"
STRANGER_STYLE_FILE="$STYLES/my_stranger/"
STRANGER_TYP="$STYLES/my_stranger.typ"
GENERIC_STYLE_FILE="$STYLES/generic_new/"
GENERIC_TYP="$STYLES/generic_new.typ"

DATE=`date +%F`

echo "TEMP_DIR = $TEMP_DIR "
echo "STYLES = $STYLES "
echo "BOUNDS = $BOUNDS "
echo "STRANGER_STYLE_FILE = $STRANGER_STYLE_FILE "
echo "TEMPLATE_ARGS = $TEMPLATE_ARGS "
echo "STRANGER_TYP = $STRANGER_TYP "
echo "DATE = $DATE"
echo "OUT_DIR = $OUT_DIR"

mkdir -p $OUT_DIR

COUNTRY_NAME=Lithuania
COUNTRY_CODE=LT
NAME="${COUNTRY_NAME}_map"

./build_map.sh -i "$PBF_FILE" -o "$OUT_DIR/${NAME}_generic.img" \
	-m "$MKGMAP" -S "$SPLITTER" \
	-f 5060 \
	-n "Lithuania OpenStreetMap.by generic" \
	-e "Lithuania OpenStreetMap.by generic" \
	-d "OSM default mkgmap style" \
	-c "$COUNTRY_NAME" -k $COUNTRY_CODE

./build_map.sh -i "$PBF_FILE" -o "$OUT_DIR/${NAME}_stranger.img" \
	-m "$MKGMAP" -S "$SPLITTER" \
	-s styles/my_stranger -t styles/my_stranger.typ \
	-f 5062 \
	-n "Lithuania OpenStreetMap + ST-GIS by Maks Vasilev" \
	-e "Lithuania OpenStreetMap.by velo100" \
	-y "OpenStreetMap CC-BY-SA 2.0, ST-GIS CC-BY-SA 3.0, ST-GIS, Maks Vasilev" \
	-d "Lithuania_velo100, v.$DATE" \
	-c "$COUNTRY_NAME" -k $COUNTRY_CODE

./build_map.sh -i "$PBF_FILE" -o "$OUT_DIR/${NAME}_generic_new.img" \
	-m "$MKGMAP" -S "$SPLITTER" \
	-s styles/generic_new -t styles/generic_new.typ \
	-f 5063 \
	-n "Lithuania OpenStreetMap generic, new" \
	-e "Lithuania OpenStreetMap.by generic, new" \
	-d "Lithuania_generic_new, v.$DATE" \
	-c "$COUNTRY_NAME" -k $COUNTRY_CODE

./build_map.sh -i "$PBF_FILE" -o "$OUT_DIR/${NAME}_rogal.img" \
	-m "$MKGMAP" -S "$SPLITTER" \
	-s styles/rogal -t styles/rogal.typ \
	-f 5067 \
	-n "Lithuania OpenStreetMap rogal, new" \
	-e "Lithuania OpenStreetMap.by rogal, new" \
	-d "Lithuania_rogal, v.$DATE" \
	-c "$COUNTRY_NAME" -k $COUNTRY_CODE

