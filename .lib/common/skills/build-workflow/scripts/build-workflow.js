#!/usr/bin/env node
// build-workflow — ~/.dynamic-builder/.agent/common/scripts/에 위임
process.env.AGENT_HOME = "__AGENT_HOME__";
const { execFileSync } = require("child_process");
const path = require("path");
const script = path.join(process.env.HOME, ".dynamic-builder/.agent/common/scripts/build-workflow.js");
execFileSync("node", [script, ...process.argv.slice(2)], { stdio: "inherit" });
