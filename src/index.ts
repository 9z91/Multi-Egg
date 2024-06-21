// import { $ } from "bun";
import figlet from "figlet";

import { DEFAULT_EGG_NAME } from "~/constants";

const initializeApp = async () => {
  figlet(DEFAULT_EGG_NAME, (error, data) => {
    if (error) {
      return;
    }
    console.log(data);
  });
};

initializeApp();
