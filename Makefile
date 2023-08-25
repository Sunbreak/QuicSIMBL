WORKING_DIR=$(shell pwd)

PROJECT_NAME=QuicSIMBL
BUILD_DIR=.build

AGENT_NAME=${PROJECT_NAME}Agent
AGENT_SRC=LaunchAgent
AGENT_APP=${BUILD_DIR}/${AGENT_NAME}.app

ADDITION_NAME=${PROJECT_NAME}Addition
ADDITION_SRC=ScriptingAddition
ADDITION_BUNDLE=${BUILD_DIR}/${ADDITION_NAME}.osax

clean:
	rm -rf ${BUILD_DIR}

buildAgent:
	mkdir -p ${AGENT_APP}/Contents/MacOS
	xcrun clang ${AGENT_SRC}/main.m \
		-framework Foundation -framework Cocoa -framework ScriptingBridge \
		-o ${AGENT_APP}/Contents/MacOS/${AGENT_NAME}

installAgent: buildAgent
	cp ${AGENT_SRC}/app.plist ${AGENT_APP}/Contents/Info.plist

prepareLaunchInfo:
	cp ${AGENT_SRC}/launch.plist ${BUILD_DIR}
	/usr/libexec/PlistBuddy -c "Set :Program ${WORKING_DIR}/${AGENT_APP}/Contents/MacOS/${AGENT_NAME}" ${BUILD_DIR}/launch.plist

loadAgent: installAgent prepareLaunchInfo
	launchctl load -F ${BUILD_DIR}/launch.plist

unloadAgent: prepareLaunchInfo
	launchctl unload -F ${BUILD_DIR}/launch.plist

buildAddition:
	mkdir -p ${ADDITION_BUNDLE}/Contents/MacOS
	xcrun clang -bundle ${ADDITION_SRC}/addition.m \
		-framework Foundation -framework Cocoa \
		-o ${ADDITION_BUNDLE}/Contents/MacOS/${ADDITION_NAME}

installAddition: buildAddition
	mkdir -p ${ADDITION_BUNDLE}/Contents/Resources
	cp ${ADDITION_SRC}/addition.plist ${ADDITION_BUNDLE}/Contents/Info.plist
	cp ${ADDITION_SRC}/addition.sdef ${ADDITION_BUNDLE}/Contents/Resources/${ADDITION_NAME}.sdef

loadAddition: installAddition
	mkdir -p ${HOME}/Library/ScriptingAdditions/
	cp -r ${ADDITION_BUNDLE} ${HOME}/Library/ScriptingAdditions/

unloadAddition:
	rm -rf ${HOME}/Library/ScriptingAdditions/${ADDITION_NAME}.osax

.PHONY: clean \
		buildAgent installAgent prepareLaunchInfo loadhAgent unloadAgent \
		buildAddition installAddition loadAddition unloadAddition