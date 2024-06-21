import confirm from "@inquirer/confirm";
import { rawlist } from "@inquirer/prompts";

const selectJavaVersion = async () => {
  const answer = await rawlist({
    message: "Select your server version.",
    choices: [
      { name: "1.20.6", value: "1.20.6" },
      { name: "1.16.5", value: "1.16.5" },
    ],
  });

  return handleSelection(answer);
};

const handleSelection = async (value: string) => {
  const accepted = await handleEulaAgreement();

  if (!accepted) {
    console.log("You have to agree to the Minecraft EULA to proceed.");
    return;
  }

  switch (value) {
    case "1.20.6":
      console.log("TODO: a");
  }
};

const handleEulaAgreement = async () => {
  const answer = await confirm({
    message: "Do you agree to the Minecraft EULA?",
    default: true,
  });

  return answer;
};

export { selectJavaVersion, handleSelection, handleEulaAgreement };
