import figlet from "figlet";
import boxen from "boxen";
import chalk from "chalk";

import { DEFAULT_EGG_NAME } from "../constants";

const displayWatermark = async () => {
  const watermark = figlet(
    DEFAULT_EGG_NAME,
    {
      font: "ANSI Shadow",
    },
    (error, data) => {
      if (error) {
        return;
      }

      const title = chalk.cyan(data!);

      const output = boxen(title, {
        title: chalk.green("https://github.com/9z91/Multi-Egg"),
        titleAlignment: "center",
        padding: 1,
        height: 10,
        borderStyle: "singleDouble",
      });

      console.log(chalk.white(output));
    },
  );

  return watermark;
};

const clearScreen = () => {
  return process.stdout.write("\x1Bc");
};

const captializeText = (value: string) => {
  return value.charAt(0).toUpperCase() + value.slice(1);
};

export { displayWatermark, clearScreen, captializeText };
