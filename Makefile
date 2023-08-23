WORKING_DIR=$(shell pwd)

PROJECT_NAME=QuicSIMBL
BUILD_DIR=.build
AGENT_NAME=${PROJECT_NAME}Agent
AGENT_SRC=agent
AGENT_APP=${BUILD_DIR}/${AGENT_NAME}.app

clean:
	rm -rf ${BUILD_DIR}

buildAgent:
	mkdir -p ${AGENT_APP}/Contents/MacOS
	xcrun clang ${AGENT_SRC}/main.m \
		-framework Foundation -framework Cocoa \
		-o ${AGENT_APP}/Contents/MacOS/${AGENT_NAME}

installAgentApp: buildAgent
	cp ${AGENT_SRC}/app.plist ${AGENT_APP}/Contents/Info.plist

runAgentApp: installAgentApp
	open ${AGENT_APP}

prepareLaunchInfo:
	cp ${AGENT_SRC}/launch.plist ${BUILD_DIR}
	/usr/libexec/PlistBuddy -c "Set :Program ${WORKING_DIR}/${AGENT_APP}/Contents/MacOS/${AGENT_NAME}" ${BUILD_DIR}/launch.plist

loadAgent: buildAgent prepareLaunchInfo
	launchctl load -F ${BUILD_DIR}/launch.plist

unloadAgent: prepareLaunchInfo
	launchctl unload -F ${BUILD_DIR}/launch.plist

.PHONY: clean \
		buildAgent installAgentApp runAgentApp \
		prepareLaunchInfo loadhAgent unloadAgent