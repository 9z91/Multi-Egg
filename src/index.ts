// import { $ } from "bun";
import figlet from "figlet";
import boxen from "boxen";
import chalk from "chalk";

import { DEFAULT_EGG_NAME } from "~/constants";

const initializeApp = async () => {
  figlet(DEFAULT_EGG_NAME, (error, data) => {
    if (error) {
      return;
    }

    const output = boxen(data!, {
      title: "9z91",
      titleAlignment: "center",
      padding: 1,
    });

    console.log(chalk.blue(output));
  });
};

initializeApp();
