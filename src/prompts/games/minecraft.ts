import { rawlist } from "@inquirer/prompts"; // confirm prompt is broken on ptero

import { PaperClient } from "../../lib/client";
import { captializeText } from "../../lib/utils";
import { installMinecraftServer } from "~/installers/minecraft";

const selectProject = async () => {
    const request = await PaperClient.get("v2/projects");

    const response: { projects: Array<string> } = await request.json();

    const answer = await rawlist({
        message: "Select your server project.",
        choices: response.projects.map((item) => ({
            name: captializeText(item),
            value: item,
        })),
    });

    await selectVersion(answer);
};

const selectBuildVersion = async (project: string, version: string) => {
    const request = await PaperClient.get(
        `v2/projects/${project}/versions/${version}/builds`
    );

    const response: {
        builds: Array<{
            build: string;
            downloads: {
                application: {
                    name: string;
                    sha265: string; // TODO: compare hash
                };
            };
        }>;
    } = await request.json();

    const build = await rawlist({
        message:
            "Select your server build (If unsure, select the highest one).",
        choices: response.builds
            .map((item) => ({
                name: item.build,
                value: item.build,
            }))
            .reverse(),
    });

    await installMinecraftServer({
        project,
        version,
        build,
        file_name: response.builds.find((item) => {
            return item.build === build;
        })?.downloads.application.name,
    });
};

const selectVersion = async (project: string) => {
    const request = await PaperClient.get(`v2/projects/${project}`);

    const response: { versions: Array<string> } = await request.json();

    const answer = await rawlist({
        message: "Select your server version.",
        choices: response.versions.map((item) => ({
            name: item,
            value: item,
        })),
    });

    await selectBuildVersion(project, answer);
};

const handleEulaAgreement = async () => {
    const approved = await rawlist({
        message: "Do you agree to the Minecraft EULA?",
        choices: [
            { name: "Yes", value: "y" },
            { name: "No", value: "n" },
        ],
    });

    if (approved !== "y") {
        console.log("You have to agree to the Minecraft EULA to proceed.");
        process.exit(1);
    }

    await selectProject();
};

export {
    selectVersion,
    selectBuildVersion,
    selectProject,
    handleEulaAgreement,
};
