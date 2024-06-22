import { rawlist, confirm } from "@inquirer/prompts";

import { PaperClient } from "../../lib/client";
import { captializeText } from "../../lib/utils";

const selectProject = async () => {
  const response = await PaperClient.get("v2/projects");

  const projects = response.data.projects as Array<string>;

  const answer = await rawlist({
    message: "Select your server project.",
    choices: projects.map((item: string) => ({
      name: captializeText(item),
      value: item,
    })),
  });

  await selectVersion(answer);
};

const selectVersion = async (project: string) => {
  const response = await PaperClient.get(`v2/projects/${project}`);

  const versions = response.data.versions as Array<string>;

  const answer = await rawlist({
    message: "Select your server version.",
    choices: versions.map((item: string) => ({
      name: item,
      value: item,
    })),
  });

  await handleSelection(answer);
};

const handleSelection = async (value: string) => {
  switch (value) {
    case "1.20.6":
      console.log("TODO: a");
      break;
  }
};

const handleEulaAgreement = async () => {
  const accepted = await confirm(
    {
      message: "Do you agree to the Minecraft EULA?",
    },
    {
      clearPromptOnDone: false,
    },
  );

  if (!accepted) {
    console.log("You have to agree to the Minecraft EULA to proceed.");
    process.exit(1);
  }

  await selectProject();
};

export { selectVersion, handleSelection, handleEulaAgreement };
