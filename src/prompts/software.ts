import { rawlist } from "@inquirer/prompts";

const selectSoftware = async () => {
  const answer = await rawlist({
    message: "Select your preferred software.",
    choices: [
      { name: "Minecraft", value: "minecraft" },
      { name: "NodeJS", value: "nodejs" },
    ],
  });

  return answer;
};

export { selectSoftware };
