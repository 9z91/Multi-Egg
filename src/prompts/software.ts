import { rawlist } from "@inquirer/prompts";

const selectSoftware = async () => {
  const answer = await rawlist({
    message: "Select your preferred software.",
    choices: [
      { name: "Minecraft", value: "minecraft" },
      { name: "Teamspeak", value: "teamspeak" },
      { name: "Lavalink", value: "lavalink" },
      { name: "NodeJS", value: "nodejs" },
    ],
  });

  return answer;
};

export { selectSoftware };
