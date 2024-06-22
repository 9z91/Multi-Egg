import { $ } from "bun";
import chalk from "chalk";

import { PAPER_IO_API_URL } from "../constants";

interface Build {
    project: string;
    build: string;
    version: string;
    file_name: string | undefined;
}

const downloadServerJar = async (data: Build) => {
    const { project, build, version, file_name } = data;
    const url = `/v2/projects/${project}/versions/${version}/builds/${build}/downloads/${file_name}`;

    await $`wget ${PAPER_IO_API_URL}${url}`;
};

const installMinecraftServer = async (data: Build) => {
    const message = chalk.bold(`Downloading ${data.file_name}...`);

    console.log(message);

    await downloadServerJar(data);
};

export { downloadServerJar, installMinecraftServer };
