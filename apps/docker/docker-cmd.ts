import { Command } from "https://cdn.depjs.com/cmd/mod.ts";
import * as ink from "https://deno.land/x/ink/mod.ts";
import {
  Input,
  Select,
} from "https://deno.land/x/cliffy@v0.18.2/prompt/mod.ts";

const program = new Command();

const envBuild = {
  COMPOSE_DOCKER_CLI_BUILD: "1",
  DOCKER_BUILDKIT: "1",
};

program
  .name("acore.sh docker")
  .description("Shell scripts for docker")
  .version("1.0.0");

shellCommandFactory(
  "start:app",
  "Startup the authserver and worldserver apps",
  ["docker-compose --profile app up"],
);

shellCommandFactory(
  "start:app:d",
  "Startup the authserver and worldserver apps in detached mode",
  ["docker-compose --profile app up -d"],
);

shellCommandFactory("build", "Build the authserver and worldserver", [
  "docker-compose --profile all build --parallel",
  "docker image prune -f",
  "docker-compose run --rm ac-build bash apps/docker/docker-build-dev.sh",
]);

shellCommandFactory(
  "build:clean",
  "Clean and run build",
  [
    "docker-compose --profile all build --parallel",
    "docker image prune -f",
    `docker-compose run --rm ac-build bash acore.sh compiler clean`,
    "docker-compose run --rm ac-build bash apps/docker/docker-build-dev.sh",
  ],
);

shellCommandFactory(
  "build:nocache",
  "Build the authserver and worldserver without docker cache",
  [
    "docker-compose --profile all build --no-cache --parallel",
    "docker image prune -f",
    "docker-compose run --rm ac-build bash apps/docker/docker-build-dev.sh",
  ],
);

shellCommandFactory(
  "build:compile",
  "Run the compilation process only, without rebuilding all docker images and importing db",
  [
    "docker-compose build  --parallel ac-build",
    "docker image prune -f",
    "docker-compose run --rm ac-build bash apps/docker/docker-build-dev.sh",
  ],
);

shellCommandFactory(
  "client-data",
  "Download client data inside the ac-data volume",
  ["docker-compose run --rm ac-worldserver bash acore.sh client-data"],
);

shellCommandFactory(
  "db-import",
  "Create and upgrade the database with latest updates",
  ["docker-compose run --rm ac-build bash acore.sh db-assembler import-all"],
);

shellCommandFactory(
  "dev:up",
  "Start the dev server container",
  ["docker-compose up ac-dev-server"],
);

shellCommandFactory(
  "dev:build",
  "Build using the dev server, it uses volumes to compile which can be faster on linux & WSL",
  ["docker-compose run --rm ac-dev-server bash acore.sh compiler build"],
);

shellCommandFactory(
  "dev:dash [args...]",
  "Execute acore dashboard within a running ac-dev-server",
  ["docker-compose run --rm ac-dev-server bash acore.sh"],
);

shellCommandFactory(
  "dev:shell [args...]",
  "Open an interactive shell within the dev server",
  ["docker-compose run --rm ac-dev-server bash"],
);

shellCommandFactory(
  "prod:build",
  "Build producion services",
  ["docker-compose --profile prod build --parallel"],
  envBuild,
);

shellCommandFactory(
  "prod:pull",
  "Pull production services from the remote registry",
  ["docker-compose --profile prod pull"],
);

shellCommandFactory(
  "prod:up",
  "Start production services (foreground)",
  ["docker-compose --profile prod up"],
);

shellCommandFactory(
  "prod:up:d",
  "Start production services (background)",
  ["docker-compose --profile prod up -d"],
);

program
  .command("attach [service]")
  .description("attach to a service")
  .action(async (service: string | undefined) => {
    const { run } = Deno;

    let command = `docker-compose ps`;

    if (service) {
      command = `${command} ${service}`;
    }

    console.log(ink.colorize(`<green>>>>>> Running: ${command}</green>`));

    let cmd = command.split(" ");
    const res = Deno.run({
      cmd,
      cwd: process.cwd(),
      stdout: "piped",
      stderr: "piped",
    });

    const output = await res.output(); // "piped" must be set

    let services = new TextDecoder().decode(output).split("\n");

    if (!services) {
      console.error("No services available!");
      return;
    }

    services.pop();
    services = services.slice(2);

    res.close(); // Don't forget to close it

    let selService: string;
    if (services.length > 1) {
      selService = await Select.prompt({
        message: `Select a service`,
        options: services,
      });
    } else {
      selService = services[0];
    }

    if (!selService) {
      console.log(`Service ${service} is not available`);
      return;
    }

    command = `docker attach ${selService.split(" ")[0]}`;

    console.log(ink.colorize(`<green>>>>>> Running: ${command}</green>`));

    console.log(
      ink.colorize(
        "<yellow>NOTE: you can detach from a container and leave it running using the CTRL-p CTRL-q key sequence.</yellow>",
      ),
    );

    cmd = command.split(" ");

    const shellCmd = run({
      cmd,
      cwd: process.cwd(),
    });

    await shellCmd.status();

    shellCmd.close();
  });

program
  .command("quit")
  .description("Close docker command")
  .action(() => {
    process.exit(0);
  });

// Handle it however you like
// e.g. display usage
while (true) {
  if (Deno.args.length === 0) {
    program.outputHelp();
    const command = await Input.prompt({
      message: "Enter the command:",
    });
    console.log(command);
    await program.parseAsync(command.split(" "));
  } else {
    await program.parseAsync(Deno.args);
    process.exit(0);
  }
}

/**
 *
 * @param name
 * @param description
 * @param commands you can pass one or more commands, they will be executed sequentially
 * @returns
 */
function shellCommandFactory(
  name: string,
  description: string,
  commands: string[],
  env?: { [key: string]: string },
): Command {
  return program
    .command(name)
    .description(
      `${description}. Command: \n"${
        ink.colorize(
          `<green>${commands.join(" && ")}</green>`,
        )
      }"\n`,
    )
    .action(async (args: any[] | undefined) => {
      const { run } = Deno;

      for (const command of commands) {
        console.log(
          ink.colorize(`<green>>>>>> Running: ${command}</green>`),
        );

        const cmd = command.split(" ");

        if (Array.isArray(args)) {
          cmd.push(...args);
        }

        const shellCmd = run({
          cmd,
          cwd: process.cwd(),
          env,
        });

        const status = await shellCmd.status();

        if (!status.success) {
          throw new Error(`Failed with error: ${status.code}, however,
            it's not related to this Deno script directly. An error occurred within
            the script called by the command itself`);
        }

        shellCmd.close();
      }
    });
}
