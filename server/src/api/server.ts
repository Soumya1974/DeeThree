import app from "./app";
import { env } from "../shared/config/env";

const server = app.listen(env.PORT, () => {
    console.log(`Server is live on port: ${env.PORT}`);
});