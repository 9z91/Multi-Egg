import { rawlist, confirm } from "@inquirer/prompts";

import { PaperClient } from "../../lib/client";
import { captializeText } from "../../lib/utils";

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
