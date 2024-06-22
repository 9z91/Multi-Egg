import ky from "ky";

export const PaperClient = ky.create({
    prefixUrl: "https://api.papermc.io",
    timeout: 8000,
    headers: {
        Accept: "application/json",
    },
});
