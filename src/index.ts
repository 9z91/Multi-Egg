// import { $ } from "bun";

import { clearScreen, displayWatermark } from "./lib/utils";
import { selectJavaVersion, selectSoftware } from "./prompts";

const initializeApp = async () => {
  clearScreen();

  await displayWatermark();

  const software = await selectSoftware();

  switch (software) {
    case "minecraft":
      await selectJavaVersion();
  }
};

initializeApp();
