import figlet from "figlet";
import boxen from "boxen";
import chalk from "chalk";

import { DEFAULT_EGG_NAME } from "../constants";

const displayWatermark = async () => {
  const watermark = figlet(DEFAULT_EGG_NAME, (error, data) => {
    if (error) {
      return;
    }

    const title = chalk.yellowBright(data!);

    const output = boxen(title, {
      title: "https://github.com/9z91/Multi-Egg",
      titleAlignment: "center",
      padding: 1,
      margin: 1,
      borderStyle: "double",
    });

    console.log(chalk.gray(output));
  });

  return watermark;
};

const clearScreen = () => {
  return process.stdout.write("\x1Bc");
};

export { displayWatermark, clearScreen };
