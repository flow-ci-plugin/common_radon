# ************************************************************
#
# This step will use Python anlayzer Radon to check files
#
#   Variables used:
#
#   Outputs:
#     $FLOW_RADON_CC_LOG_PATH
#     $FLOW_RADON_RAW_LOG_PATH
#     $FLOW_RADON_MI_LOG_PATH
#     $FLOW_FILE_RADON_CC_FILE_COUNT
#     $FLOW_FILE_RADON_CC_WARN_COUNT
#
# ************************************************************

set +e
cd $FLOW_CURRENT_PROJECT_PATH
pip install radon
FLOW_RADON_CC_LOG_PATH="${FLOW_WORKSPACE}/output/radon_cc.json"
FLOW_RADON_RAW_LOG_PATH="${FLOW_WORKSPACE}/output/radon_raw.json"
FLOW_RADON_MI_LOG_PATH="${FLOW_WORKSPACE}/output/radon_mi.json"
radon cc . -j  > $FLOW_RADON_CC_LOG_PATH
radon raw . -j  > $FLOW_RADON_RAW_LOG_PATH
radon mi . -j > $FLOW_RADON_MI_LOG_PATH

FLOW_FILE_RADON_CC_FILE_COUNT=$(cat $FLOW_RADON_CC_LOG_PATH | jq '. | length' $FLOW_RADON_CC_LOG_PATH | awk '{s+=$1} END {print s}')
FLOW_FILE_RADON_CC_WARN_COUNT=$(cat $FLOW_RADON_CC_LOG_PATH | jq '.[] | length' $FLOW_RADON_CC_LOG_PATH | awk '{s+=$1} END {print s}')

echo "CHECK FILE COUNT $FLOW_FILE_RADON_CC_FILE_COUNT"
echo "CHECK WARN COUNT $FLOW_FILE_RADON_CC_WARN_COUNT"
