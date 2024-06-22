import { clearScreen, displayWatermark } from "./lib/utils";
import { handleEulaAgreement, selectSoftware } from "./prompts";

const initializeApp = async () => {
  clearScreen();

  await displayWatermark();

  const software = await selectSoftware();

  switch (software) {
    case "minecraft":
      await handleEulaAgreement();
      break;
  }
};

initializeApp();
