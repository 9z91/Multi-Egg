// import { $ } from "bun";
import figlet from "figlet";
import boxen from "boxen";
import chalk from "chalk";

import { DEFAULT_EGG_NAME } from "./constants";

const initializeApp = async () => {
  figlet(
    DEFAULT_EGG_NAME,
    {
      font: "Banner3-D",
    },
    (error, data) => {
      if (error) {
        return;
      }

      const title = chalk.yellowBright(data!);

      const output = boxen(title, {
        title: chalk.underline("https://github.com/9z91/Multi-Egg"),
        titleAlignment: "center",
        padding: 1,
        margin: 1,
        borderStyle: "double",
      });

      console.log(chalk.gray(output));
    },
  );
};

initializeApp();
