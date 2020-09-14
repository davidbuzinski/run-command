// Copyright 2020 The MathWorks, Inc.

import * as core from "@actions/core";
import * as exec from "@actions/exec";
import * as matlab from "./matlab";

export { matlab };

async function run() {
    const platform = process.platform;
    const workspaceDir = process.cwd();
    const command = core.getInput("command");

    const helperScript = await core.group("Generate script", async () => {
        const helperScript = await matlab.generateScript(workspaceDir, command);
        core.info("Sucessfully generated script");
        return helperScript;
    });

    await core.group("Run command", async () => {
        await matlab.runCommand(helperScript, platform, exec.exec);
    });
}

run().catch((e) => {
    core.setFailed(e);
});
